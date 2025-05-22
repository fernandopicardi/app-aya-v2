import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../widgets/admin_widgets.dart';
import '../models/admin_models.dart';

class AdminGamificationScreen extends StatefulWidget {
  const AdminGamificationScreen({super.key});

  @override
  State<AdminGamificationScreen> createState() =>
      _AdminGamificationScreenState();
}

class _AdminGamificationScreenState extends State<AdminGamificationScreen>
    with SingleTickerProviderStateMixin {
  final _adminService = AdminService();
  late TabController _tabController;
  bool _isLoading = true;
  List<AdminChallenge> _challenges = [];
  List<AdminBadge> _badges = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadGamification();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadGamification() async {
    setState(() => _isLoading = true);
    try {
      final challenges = await _adminService.getChallenges();
      final badges = await _adminService.getBadges();

      setState(() {
        _challenges = challenges;
        _badges = badges;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar gamificação: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteChallenge(AdminChallenge challenge) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Desafio'),
        content: Text(
          'Tem certeza que deseja excluir o desafio ${challenge.title}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _adminService.deleteChallenge(challenge.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Desafio excluído com sucesso'),
              backgroundColor: Colors.green,
            ),
          );
          _loadGamification();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao excluir desafio: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _deleteBadge(AdminBadge badge) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Badge'),
        content: Text(
          'Tem certeza que deseja excluir o badge ${badge.name}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _adminService.deleteBadge(badge.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Badge excluído com sucesso'),
              backgroundColor: Colors.green,
            ),
          );
          _loadGamification();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao excluir badge: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gamificação'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Desafios'),
            Tab(text: 'Badges'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadGamification,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildChallengesList(),
                _buildBadgesList(),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implementar tela de criação de desafio/badge
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildChallengesList() {
    return RefreshIndicator(
      onRefresh: _loadGamification,
      child: ListView.builder(
        itemCount: _challenges.length,
        itemBuilder: (context, index) {
          final challenge = _challenges[index];
          return AdminChallengeListTile(
            challenge: challenge,
            onTap: () {
              // TODO: Implementar tela de detalhes do desafio
            },
            onEdit: () {
              // TODO: Implementar tela de edição do desafio
            },
            onDelete: () => _deleteChallenge(challenge),
          );
        },
      ),
    );
  }

  Widget _buildBadgesList() {
    return RefreshIndicator(
      onRefresh: _loadGamification,
      child: ListView.builder(
        itemCount: _badges.length,
        itemBuilder: (context, index) {
          final badge = _badges[index];
          return AdminBadgeListTile(
            badge: badge,
            onTap: () {
              // TODO: Implementar tela de detalhes do badge
            },
            onEdit: () {
              // TODO: Implementar tela de edição do badge
            },
            onDelete: () => _deleteBadge(badge),
          );
        },
      ),
    );
  }
}
