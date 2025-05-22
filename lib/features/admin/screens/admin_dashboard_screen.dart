import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../widgets/admin_widgets.dart';
import '../screens/admin_users_screen.dart';
import '../screens/admin_content_screen.dart';
import '../screens/admin_moderation_screen.dart';
import '../screens/admin_gamification_screen.dart';
import '../models/admin_models.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final _adminService = AdminService();
  bool _isLoading = true;
  late AdminStats _stats;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() => _isLoading = true);
    try {
      _stats = await _adminService.getStats();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar estatísticas: $e'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Administrativo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadStats,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadStats,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  AdminStatsCard(stats: _stats),
                  const SizedBox(height: 24),
                  AdminActionCard(
                    title: 'Gerenciar Conteúdo',
                    subtitle: 'Módulos, Pastas e Aulas',
                    icon: Icons.article,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminContentScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AdminActionCard(
                    title: 'Gerenciar Usuários',
                    subtitle: 'Perfis, Roles e Assinaturas',
                    icon: Icons.people,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminUsersScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AdminActionCard(
                    title: 'Moderação',
                    subtitle: 'Comentários e Fóruns',
                    icon: Icons.flag,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminModerationScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AdminActionCard(
                    title: 'Gamificação',
                    subtitle: 'Desafios e Badges',
                    icon: Icons.emoji_events,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminGamificationScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
