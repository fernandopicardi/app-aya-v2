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
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _orderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadModules();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _orderController.dispose();
    super.dispose();
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar módulos: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _createModule() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final supabase = Supabase.instance.client;
      final order = int.tryParse(_orderController.text) ?? 0;

      await supabase.from('modules').insert({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'order': order,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;

      // Limpar formulário
      _titleController.clear();
      _descriptionController.clear();
      _orderController.clear();

      // Fechar modal
      Navigator.of(context).pop();

      // Recarregar módulos
      await _loadModules();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Módulo criado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao criar módulo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteModule(String moduleId) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('modules').delete().eq('id', moduleId);

      if (!mounted) return;

      // Recarregar módulos
      await _loadModules();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Módulo excluído com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao excluir módulo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showCreateModuleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo Módulo'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
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
                controller: _descriptionController,
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
                controller: _orderController,
                decoration: const InputDecoration(
                  labelText: 'Ordem',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a ordem';
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
            onPressed: _createModule,
            child: const Text('Criar'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(String moduleId, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem certeza que deseja excluir o módulo "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteModule(moduleId);
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
              onPressed: _showCreateModuleDialog,
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
                      onPressed: () => _showDeleteConfirmationDialog(
                        module['id'],
                        module['title'],
                      ),
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
