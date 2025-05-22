import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/logging_service.dart';

class AdminModerationSection extends StatefulWidget {
  const AdminModerationSection({super.key});

  @override
  State<AdminModerationSection> createState() => _AdminModerationSectionState();
}

class _AdminModerationSectionState extends State<AdminModerationSection> {
  final _supabase = Supabase.instance.client;
  final _logger = LoggingService();
  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = true;
  String? _error;
  String _filter = 'pending'; // pending, approved, rejected

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final response = await _supabase
          .from('posts')
          .select('*, users!inner(*)')
          .eq('status', _filter)
          .order('created_at', ascending: false);

      setState(() {
        _posts = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });

      _logger.info('Loaded ${_posts.length} posts with filter: $_filter');
    } catch (e, stackTrace) {
      _logger.error('Error loading posts', e, stackTrace);
      setState(() {
        _error = 'Erro ao carregar posts: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _updatePostStatus(String postId, String status) async {
    try {
      await _supabase.from('posts').update({'status': status}).eq('id', postId);

      // Registrar ação no log
      await _supabase.from('admin_logs').insert({
        'action': 'update',
        'description': 'Post $postId $status',
        'admin_name': _supabase.auth.currentUser?.email,
        'created_at': DateTime.now().toIso8601String(),
      });

      _logger.info('Updated post $postId status to $status');

      if (!mounted) {
        return;
      }
      await _loadPosts();

      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Post ${status == 'approved' ? 'aprovado' : 'rejeitado'} com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e, stackTrace) {
      _logger.error('Error updating post status', e, stackTrace);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar status: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showPostDetails(Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detalhes do Post'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Autor: ${post['users']['name']}'),
              const SizedBox(height: 8),
              Text('Data: ${_formatDate(post['created_at'])}'),
              const SizedBox(height: 16),
              const Text('Conteúdo:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(post['content'] ?? ''),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
          if (_filter == 'pending') ...[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updatePostStatus(post['id'], 'rejected');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Rejeitar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updatePostStatus(post['id'], 'approved');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Aprovar'),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Moderação de Conteúdo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadPosts,
              tooltip: 'Atualizar lista',
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Gerencie posts e comentários da comunidade.'),
        const SizedBox(height: 16),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(
              value: 'pending',
              label: Text('Pendentes'),
              icon: Icon(Icons.pending),
            ),
            ButtonSegment(
              value: 'approved',
              label: Text('Aprovados'),
              icon: Icon(Icons.check_circle),
            ),
            ButtonSegment(
              value: 'rejected',
              label: Text('Rejeitados'),
              icon: Icon(Icons.cancel),
            ),
          ],
          selected: {_filter},
          onSelectionChanged: (Set<String> newSelection) {
            setState(() {
              _filter = newSelection.first;
            });
            _loadPosts();
          },
        ),
        const SizedBox(height: 32),
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else if (_error != null)
          Center(
            child: Column(
              children: [
                Text(_error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadPosts,
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          )
        else if (_posts.isEmpty)
          Center(
            child: Text(
              'Nenhum post ${_filter == 'pending' ? 'pendente' : _filter == 'approved' ? 'aprovado' : 'rejeitado'}.',
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(post['users']['name'][0].toUpperCase()),
                    ),
                    title: Text(post['users']['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['content'] ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _formatDate(post['created_at']),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () => _showPostDetails(post),
                      tooltip: 'Ver detalhes',
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
