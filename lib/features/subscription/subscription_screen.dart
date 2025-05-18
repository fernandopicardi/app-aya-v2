import 'package:flutter/material.dart';
import 'package:app_aya_v2/services/subscription_service.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late Future<List<Map<String, dynamic>>> _plansFuture;
  late Future<Map<String, dynamic>?> _currentSubscriptionFuture;
  final _service = SubscriptionService();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _plansFuture = _service.getPlans();
      _currentSubscriptionFuture = _service.getCurrentSubscription();
    });
  }

  Future<void> _subscribeToPlan(String planId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await _service.subscribeToPlan(planId);
      _loadData();
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao assinar plano';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _cancelSubscription(String subscriptionId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await _service.cancelSubscription(subscriptionId);
      _loadData();
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao cancelar assinatura';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assinatura')),
      body: Column(
        children: [
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_errorMessage!,
                  style: const TextStyle(color: Colors.red)),
            ),
          Expanded(
            child: FutureBuilder<Map<String, dynamic>?>(
              future: _currentSubscriptionFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    _isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Erro ao carregar assinatura: ${snapshot.error}'));
                }
                final subscription = snapshot.data;
                if (subscription != null) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Assinatura Ativa: ${subscription['plan_id']}'),
                        Text('Início: ${subscription['start_date']}'),
                        Text('Fim: ${subscription['end_date']}'),
                        ElevatedButton(
                          onPressed: () => _cancelSubscription(
                              subscription['id'].toString()),
                          child: const Text('Cancelar Assinatura'),
                        ),
                      ],
                    ),
                  );
                }
                return FutureBuilder<List<Map<String, dynamic>>>(
                  future: _plansFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              'Erro ao carregar planos: ${snapshot.error}'));
                    }
                    final plans = snapshot.data ?? [];
                    if (plans.isEmpty) {
                      return const Center(
                          child: Text('Nenhum plano disponível.'));
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: plans.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final plan = plans[index];
                        return ListTile(
                          leading: const Icon(Icons.card_membership,
                              color: Colors.green),
                          title: Text(plan['name']),
                          subtitle: Text(
                              '${plan['description']} - R\$ ${plan['price']}'),
                          trailing: ElevatedButton(
                            onPressed: () =>
                                _subscribeToPlan(plan['id'].toString()),
                            child: const Text('Assinar'),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
