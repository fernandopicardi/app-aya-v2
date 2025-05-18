import 'package:flutter/material.dart';
import 'package:app_aya_v2/services/dashboard_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<Map<String, dynamic>> _dashboardFuture;
  final _service = DashboardService();
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  void _loadDashboardData() {
    setState(() {
      _dashboardFuture = _service.getDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dashboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              _isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar dashboard: ${snapshot.error}'));
          }
          final data = snapshot.data ?? {};
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total de Visualizações: ${data['total_views']}'),
                Text('Total de Likes: ${data['total_likes']}'),
                Text('Total de Comentários: ${data['total_comments']}'),
                const SizedBox(height: 16),
                const Text('Atividade Recente:'),
                Text(data['recent_activity'] ?? 'Nenhuma atividade recente.'),
              ],
            ),
          );
        },
      ),
    );
  }
}
