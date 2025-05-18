import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminContentSection extends StatefulWidget {
  const AdminContentSection({super.key});

  @override
  State<AdminContentSection> createState() => _AdminContentSectionState();
}

class _AdminContentSectionState extends State<AdminContentSection> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _modules = [];

  @override
  void initState() {
    super.initState();
    _loadModules();
  }

  Future<void> _loadModules() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('modules')
          .select()
          .order('order', ascending: true);

      if (mounted) {
        setState(() {
          _modules = List<Map<String, dynamic>>.from(response);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Módulos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implementar criação de módulo
              },
              icon: const Icon(Icons.add),
              label: const Text('Novo Módulo'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _modules.length,
          itemBuilder: (context, index) {
            final module = _modules[index];
            return Card(
              child: ListTile(
                title: Text(module['title'] ?? ''),
                subtitle: Text(module['description'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Ordem: ${module['order']}'),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // TODO: Implementar exclusão de módulo
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
} 