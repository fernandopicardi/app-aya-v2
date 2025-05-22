import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminSettingsSection extends StatefulWidget {
  const AdminSettingsSection({super.key});

  @override
  State<AdminSettingsSection> createState() => _AdminSettingsSectionState();
}

class _AdminSettingsSectionState extends State<AdminSettingsSection> {
  final _supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;
  String? _error;
  Map<String, dynamic> _settings = {};
  final _maintenanceModeController = TextEditingController();
  final _maintenanceMessageController = TextEditingController();
  final _maxPostsPerDayController = TextEditingController();
  final _maxCommentsPerPostController = TextEditingController();
  final _pointsPerPostController = TextEditingController();
  final _pointsPerCommentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _maintenanceModeController.dispose();
    _maintenanceMessageController.dispose();
    _maxPostsPerDayController.dispose();
    _maxCommentsPerPostController.dispose();
    _pointsPerPostController.dispose();
    _pointsPerCommentController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final response = await _supabase.from('app_settings').select().single();

      setState(() {
        _settings = response;
        _maintenanceModeController.text ??=
            _settings['maintenance_mode']?.toString() ?? 'false';
        _maintenanceMessageController.text ??=
            _settings['maintenance_message'] ?? '';
        _maxPostsPerDayController.text ??=
            _settings['max_posts_per_day']?.toString() ?? '5';
        _maxCommentsPerPostController.text ??=
            _settings['max_comments_per_post']?.toString() ?? '10';
        _pointsPerPostController.text ??=
            _settings['points_per_post']?.toString() ?? '10';
        _pointsPerCommentController.text ??=
            _settings['points_per_comment']?.toString() ?? '5';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao carregar configurações: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() => _isLoading = true);

      final settings = {
        'maintenance_mode': _maintenanceModeController.text == 'true',
        'maintenance_message': _maintenanceMessageController.text,
        'max_posts_per_day': int.parse(_maxPostsPerDayController.text),
        'max_comments_per_post': int.parse(_maxCommentsPerPostController.text),
        'points_per_post': int.parse(_pointsPerPostController.text),
        'points_per_comment': int.parse(_pointsPerCommentController.text),
        'updated_at': DateTime.now().toIso8601String(),
      };

      await _supabase
          .from('app_settings')
          .update(settings)
          .eq('id', _settings['id']);

      // Registrar ação no log
      await _supabase.from('admin_logs').insert({
        'action': 'update',
        'description': 'Configurações do app atualizadas',
        'admin_name': _supabase.auth.currentUser?.email,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;
      await _loadSettings();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Configurações salvas com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar configurações: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
              'Configurações do App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadSettings,
              tooltip: 'Atualizar configurações',
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Gerencie as configurações globais do aplicativo.'),
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
                  onPressed: _loadSettings,
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          )
        else
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Modo de Manutenção',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _maintenanceModeController.text,
                      decoration: const InputDecoration(
                        labelText: 'Modo de Manutenção',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'true',
                          child: Text('Ativado'),
                        ),
                        DropdownMenuItem(
                          value: 'false',
                          child: Text('Desativado'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _maintenanceModeController.text = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _maintenanceMessageController,
                      decoration: const InputDecoration(
                        labelText: 'Mensagem de Manutenção',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (_maintenanceModeController.text == 'true' &&
                            (value == null || value.isEmpty)) {
                          return 'Por favor, insira uma mensagem de manutenção';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Limites do Sistema',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _maxPostsPerDayController,
                      decoration: const InputDecoration(
                        labelText: 'Máximo de Posts por Dia',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um valor';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Por favor, insira um número válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _maxCommentsPerPostController,
                      decoration: const InputDecoration(
                        labelText: 'Máximo de Comentários por Post',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um valor';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Por favor, insira um número válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Sistema de Pontos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _pointsPerPostController,
                      decoration: const InputDecoration(
                        labelText: 'Pontos por Post',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um valor';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Por favor, insira um número válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _pointsPerCommentController,
                      decoration: const InputDecoration(
                        labelText: 'Pontos por Comentário',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um valor';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Por favor, insira um número válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveSettings,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Text('Salvar Configurações'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
