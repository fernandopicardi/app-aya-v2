import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminUsersSection extends StatefulWidget {
  const AdminUsersSection({super.key});

  @override
  State<AdminUsersSection> createState() => _AdminUsersSectionState();
}

class _AdminUsersSectionState extends State<AdminUsersSection> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _users = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final supabase = Supabase.instance.client;
    try {
      final usersRes = await supabase
          .from('profiles')
          .select('id, username, email, role, created_at')
          .order('created_at', ascending: false);
      setState(() {
        _users = List<Map<String, dynamic>>.from(usersRes);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao carregar usuários: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserRole(String userId, String newRole) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from('profiles').update({'role': newRole}).eq('id', userId);
      setState(() {
        final idx = _users.indexWhere((u) => u['id'] == userId);
        if (idx != -1) _users[idx]['role'] = newRole;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Role atualizada para $newRole')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar role: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Usuários', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Expanded(
          child: _users.isEmpty
              ? const Center(child: Text('Nenhum usuário encontrado.'))
              : ListView.separated(
                  itemCount: _users.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, idx) {
                    final user = _users[idx];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(user['username'] != null && user['username'].isNotEmpty ? user['username'][0].toUpperCase() : '?'),
                      ),
                      title: Text(user['username'] ?? 'Sem nome'),
                      subtitle: Text(user['email'] ?? user['id']),
                      trailing: DropdownButton<String>(
                        value: user['role'] ?? 'user',
                        items: const [
                          DropdownMenuItem(value: 'user', child: Text('User')),
                          DropdownMenuItem(value: 'admin', child: Text('Admin')),
                          DropdownMenuItem(value: 'moderator', child: Text('Moderator')),
                        ],
                        onChanged: (value) {
                          if (value != null && value != user['role']) {
                            _updateUserRole(user['id'], value);
                          }
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
} 