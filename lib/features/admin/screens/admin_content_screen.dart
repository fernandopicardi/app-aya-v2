import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../widgets/admin_widgets.dart';
import '../models/admin_models.dart';

class AdminContentScreen extends StatefulWidget {
  const AdminContentScreen({super.key});

  @override
  State<AdminContentScreen> createState() => _AdminContentScreenState();
}

class _AdminContentScreenState extends State<AdminContentScreen>
    with SingleTickerProviderStateMixin {
  final _adminService = AdminService();
  late TabController _tabController;
  bool _isLoading = true;
  List<AdminContent> _modules = [];
  List<AdminContent> _folders = [];
  List<AdminContent> _lessons = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadContent();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadContent() async {
    setState(() => _isLoading = true);
    try {
      final modules = await _adminService.getContents(type: 'module');
      final folders = await _adminService.getContents(type: 'folder');
      final lessons = await _adminService.getContents(type: 'lesson');

      setState(() {
        _modules = modules;
        _folders = folders;
        _lessons = lessons;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar conteúdo: $e'),
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

  Future<void> _deleteContent(AdminContent content) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Conteúdo'),
        content: Text(
          'Tem certeza que deseja excluir ${content.title}?',
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
        await _adminService.deleteContent(content.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Conteúdo excluído com sucesso'),
              backgroundColor: Colors.green,
            ),
          );
          _loadContent();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao excluir conteúdo: $e'),
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
        title: const Text('Gerenciar Conteúdo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Módulos'),
            Tab(text: 'Pastas'),
            Tab(text: 'Aulas'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadContent,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildContentList(_modules, 'module'),
                _buildContentList(_folders, 'folder'),
                _buildContentList(_lessons, 'lesson'),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implementar tela de criação de conteúdo
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContentList(List<AdminContent> contents, String type) {
    return RefreshIndicator(
      onRefresh: _loadContent,
      child: ListView.builder(
        itemCount: contents.length,
        itemBuilder: (context, index) {
          final content = contents[index];
          return AdminContentListTile(
            content: content,
            onTap: () {
              // TODO: Implementar tela de detalhes do conteúdo
            },
            onEdit: () {
              // TODO: Implementar tela de edição do conteúdo
            },
            onDelete: () => _deleteContent(content),
          );
        },
      ),
    );
  }
}
