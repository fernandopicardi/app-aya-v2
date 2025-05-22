import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/logging_service.dart';

class AdminLogsSection extends StatefulWidget {
  const AdminLogsSection({super.key});

  @override
  State<AdminLogsSection> createState() => _AdminLogsSectionState();
}

class _AdminLogsSectionState extends State<AdminLogsSection> {
  final _supabase = Supabase.instance.client;
  final _logger = LoggingService();
  List<Map<String, dynamic>> _logs = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final response = await _supabase
          .from('admin_logs')
          .select()
          .order('created_at', ascending: false)
          .limit(100);

      setState(() {
        _logs = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });

      _logger.info('Loaded ${_logs.length} admin logs');
    } catch (e, stackTrace) {
      _logger.error('Error loading admin logs', e, stackTrace);
      setState(() {
        _error = 'Erro ao carregar logs: $e';
        _isLoading = false;
      });
    }
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
              'Logs de Auditoria',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadLogs,
              tooltip: 'Atualizar logs',
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Acompanhe ações administrativas importantes.'),
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
                  onPressed: _loadLogs,
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          )
        else if (_logs.isEmpty)
          const Center(
            child: Text('Nenhum log encontrado.'),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                final log = _logs[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    leading: Icon(
                      _getActionIcon(log['action']),
                      color: _getActionColor(log['action']),
                    ),
                    title: Text(log['action'] ?? 'Ação desconhecida'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(log['description'] ?? ''),
                        Text(
                          'Por: ${log['admin_name'] ?? 'Desconhecido'} em ${_formatDate(log['created_at'])}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  IconData _getActionIcon(String? action) {
    switch (action?.toLowerCase()) {
      case 'create':
        return Icons.add_circle;
      case 'update':
        return Icons.edit;
      case 'delete':
        return Icons.delete;
      case 'login':
        return Icons.login;
      case 'logout':
        return Icons.logout;
      default:
        return Icons.info;
    }
  }

  Color _getActionColor(String? action) {
    switch (action?.toLowerCase()) {
      case 'create':
        return Colors.green;
      case 'update':
        return Colors.blue;
      case 'delete':
        return Colors.red;
      case 'login':
        return Colors.orange;
      case 'logout':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
