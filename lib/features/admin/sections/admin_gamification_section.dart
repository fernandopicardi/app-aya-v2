import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminGamificationSection extends StatefulWidget {
  const AdminGamificationSection({super.key});

  @override
  State<AdminGamificationSection> createState() =>
      _AdminGamificationSectionState();
}

class _AdminGamificationSectionState extends State<AdminGamificationSection>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  late TabController _tabController;
  List<Map<String, dynamic>> _challenges = [];
  List<Map<String, dynamic>> _badges = [];

  // Controllers para formulários
  final _challengeFormKey = GlobalKey<FormState>();
  final _badgeFormKey = GlobalKey<FormState>();
  final _challengeTitleController = TextEditingController();
  final _challengeDescriptionController = TextEditingController();
  final _challengePointsController = TextEditingController();
  final _badgeTitleController = TextEditingController();
  final _badgeDescriptionController = TextEditingController();
  final _badgeIconController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _challengeTitleController.dispose();
    _challengeDescriptionController.dispose();
    _challengePointsController.dispose();
    _badgeTitleController.dispose();
    _badgeDescriptionController.dispose();
    _badgeIconController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final supabase = Supabase.instance.client;

      final challengesResponse = await supabase
          .from('challenges')
          .select()
          .order('created_at', ascending: false);

      final badgesResponse = await supabase
          .from('badges')
          .select()
          .order('created_at', ascending: false);

      if (!mounted) return;

      setState(() {
        _challenges = List<Map<String, dynamic>>.from(challengesResponse);
        _badges = List<Map<String, dynamic>>.from(badgesResponse);
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar dados: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _createChallenge() async {
    if (!_challengeFormKey.currentState!.validate()) return;

    try {
      final supabase = Supabase.instance.client;
      final points = int.tryParse(_challengePointsController.text) ?? 0;

      await supabase.from('challenges').insert({
        'title': _challengeTitleController.text.trim(),
        'description': _challengeDescriptionController.text.trim(),
        'points': points,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;

      // Limpar formulário
      _challengeTitleController.clear();
      _challengeDescriptionController.clear();
      _challengePointsController.clear();

      // Fechar modal
      Navigator.of(context).pop();

      // Recarregar dados
      await _loadData();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Desafio criado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao criar desafio: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _createBadge() async {
    if (!_badgeFormKey.currentState!.validate()) return;

    try {
      final supabase = Supabase.instance.client;

      await supabase.from('badges').insert({
        'title': _badgeTitleController.text.trim(),
        'description': _badgeDescriptionController.text.trim(),
        'icon': _badgeIconController.text.trim(),
        'created_at': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;

      // Limpar formulário
      _badgeTitleController.clear();
      _badgeDescriptionController.clear();
      _badgeIconController.clear();

      // Fechar modal
      Navigator.of(context).pop();

      // Recarregar dados
      await _loadData();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Badge criado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao criar badge: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteChallenge(String challengeId) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('challenges').delete().eq('id', challengeId);

      if (!mounted) return;
      await _loadData();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Desafio excluído com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao excluir desafio: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteBadge(String badgeId) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('badges').delete().eq('id', badgeId);

      if (!mounted) return;
      await _loadData();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Badge excluído com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao excluir badge: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showCreateChallengeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo Desafio'),
        content: Form(
          key: _challengeFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _challengeTitleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _challengeDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _challengePointsController,
                decoration: const InputDecoration(
                  labelText: 'Pontos',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira os pontos';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: _createChallenge,
            child: const Text('Criar'),
          ),
        ],
      ),
    );
  }

  void _showCreateBadgeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo Badge'),
        content: Form(
          key: _badgeFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _badgeTitleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _badgeDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _badgeIconController,
                decoration: const InputDecoration(
                  labelText: 'Ícone (nome do ícone)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do ícone';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: _createBadge,
            child: const Text('Criar'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      String id, String title, bool isChallenge) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            Text('Confirmar Exclusão de ${isChallenge ? "Desafio" : "Badge"}'),
        content: Text('Tem certeza que deseja excluir "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isChallenge) {
                _deleteChallenge(id);
              } else {
                _deleteBadge(id);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Desafios'),
            Tab(text: 'Badges'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Tab de Desafios
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Desafios',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _showCreateChallengeDialog,
                          icon: const Icon(Icons.add),
                          label: const Text('Novo Desafio'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _challenges.length,
                      itemBuilder: (context, index) {
                        final challenge = _challenges[index];
                        return Card(
                          child: ListTile(
                            title: Text(challenge['title'] ?? ''),
                            subtitle: Text(challenge['description'] ?? ''),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${challenge['points']} pontos'),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _showDeleteConfirmationDialog(
                                    challenge['id'],
                                    challenge['title'],
                                    true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              // Tab de Badges
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Badges',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _showCreateBadgeDialog,
                          icon: const Icon(Icons.add),
                          label: const Text('Novo Badge'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _badges.length,
                      itemBuilder: (context, index) {
                        final badge = _badges[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(
                              IconData(
                                int.parse(badge['icon'] ?? '0'),
                                fontFamily: 'MaterialIcons',
                              ),
                              size: 32,
                            ),
                            title: Text(badge['title'] ?? ''),
                            subtitle: Text(badge['description'] ?? ''),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _showDeleteConfirmationDialog(
                                badge['id'],
                                badge['title'],
                                false,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
