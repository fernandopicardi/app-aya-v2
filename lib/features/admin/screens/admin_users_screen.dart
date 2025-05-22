import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../widgets/admin_widgets.dart';
import '../models/admin_models.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final _adminService = AdminService();
  final _searchController = TextEditingController();
  bool _isLoading = true;
  List<AdminUser> _users = [];
  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoading = true);
    try {
      _users = await _adminService.getUsers(
        search: _searchQuery,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar usuários: $e'),
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

  Future<void> _updateUserRole(AdminUser user, String newRole) async {
    try {
      await _adminService.updateUserRole(user.id, newRole);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Role atualizada com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
        _loadUsers();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar role: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deactivateUser(AdminUser user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Desativar Usuário'),
        content: Text(
          'Tem certeza que deseja desativar o usuário ${user.name ?? user.email}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Desativar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _adminService.deactivateUser(user.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuário desativado com sucesso'),
              backgroundColor: Colors.green,
            ),
          );
          _loadUsers();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao desativar usuário: $e'),
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
        title: const Text('Gerenciar Usuários'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUsers,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Buscar usuários...',
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                setState(() => _searchQuery = value);
                _loadUsers();
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _loadUsers,
                    child: ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users[index];
                        return AdminUserListTile(
                          user: user,
                          onTap: () {
                            // TODO: Implementar tela de detalhes do usuário
                          },
                          onEditRole: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Alterar Role'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: const Text('Usuário'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _updateUserRole(user, 'user');
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('Admin'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _updateUserRole(user, 'admin');
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('Moderador'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _updateUserRole(user, 'moderator');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          onDeactivate: () => _deactivateUser(user),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
