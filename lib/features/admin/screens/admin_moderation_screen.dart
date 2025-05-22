import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../widgets/admin_widgets.dart';
import '../models/admin_models.dart';

class AdminModerationScreen extends StatefulWidget {
  const AdminModerationScreen({super.key});

  @override
  State<AdminModerationScreen> createState() => _AdminModerationScreenState();
}

class _AdminModerationScreenState extends State<AdminModerationScreen>
    with SingleTickerProviderStateMixin {
  final _adminService = AdminService();
  late TabController _tabController;
  bool _isLoading = true;
  List<AdminComment> _comments = [];
  bool _showOnlyReported = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadComments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    setState(() => _isLoading = true);
    try {
      _comments = await _adminService.getComments(
        isReported: _showOnlyReported ? true : null,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar comentários: $e'),
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

  Future<void> _approveComment(AdminComment comment) async {
    try {
      await _adminService.approveComment(comment.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Comentário aprovado com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
        _loadComments();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao aprovar comentário: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteComment(AdminComment comment) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Comentário'),
        content: Text(
          'Tem certeza que deseja excluir o comentário de ${comment.authorName}?',
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
        await _adminService.deleteComment(comment.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Comentário excluído com sucesso'),
              backgroundColor: Colors.green,
            ),
          );
          _loadComments();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao excluir comentário: $e'),
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
        title: const Text('Moderação'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Comentários'),
            Tab(text: 'Fóruns'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadComments,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Text('Mostrar apenas reportados:'),
                      const SizedBox(width: 8),
                      Switch(
                        value: _showOnlyReported,
                        onChanged: (value) {
                          setState(() => _showOnlyReported = value);
                          _loadComments();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildCommentsList(),
                      const Center(
                        child: Text('Em desenvolvimento'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCommentsList() {
    return RefreshIndicator(
      onRefresh: _loadComments,
      child: ListView.builder(
        itemCount: _comments.length,
        itemBuilder: (context, index) {
          final comment = _comments[index];
          return AdminCommentListTile(
            comment: comment,
            onTap: () {
              // TODO: Implementar tela de detalhes do comentário
            },
            onApprove:
                comment.isReported ? () => _approveComment(comment) : null,
            onDelete: () => _deleteComment(comment),
          );
        },
      ),
    );
  }
}
