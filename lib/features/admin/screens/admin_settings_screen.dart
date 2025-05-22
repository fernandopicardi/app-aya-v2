import 'package:flutter/material.dart';
import '../services/admin_service.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  final _adminService = AdminService();
  bool _isLoading = true;
  bool _isDarkMode = false;
  String _language = 'pt-BR';
  bool _notificationsEnabled = true;
  bool _autoSaveEnabled = true;
  int _autoSaveInterval = 5;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final settings = await _adminService.getSettings();
      if (!mounted) return;
      setState(() {
        _isDarkMode = settings.isDarkMode;
        _language = settings.language;
        _notificationsEnabled = settings.notificationsEnabled;
        _autoSaveEnabled = settings.autoSaveEnabled;
        _autoSaveInterval = settings.autoSaveInterval;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar configurações: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveSettings() async {
    try {
      await _adminService.updateSettings(
        isDarkMode: _isDarkMode,
        language: _language,
        notificationsEnabled: _notificationsEnabled,
        autoSaveEnabled: _autoSaveEnabled,
        autoSaveInterval: _autoSaveInterval,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Configurações salvas com sucesso'),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildAppearanceCard(),
                const SizedBox(height: 16),
                _buildLanguageCard(),
                const SizedBox(height: 16),
                _buildNotificationsCard(),
                const SizedBox(height: 16),
                _buildAutoSaveCard(),
              ],
            ),
    );
  }

  Widget _buildAppearanceCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aparência',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Modo escuro'),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() => _isDarkMode = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Idioma',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _language,
              decoration: const InputDecoration(
                labelText: 'Idioma do sistema',
              ),
              items: const [
                DropdownMenuItem(
                  value: 'pt-BR',
                  child: Text('Português (Brasil)'),
                ),
                DropdownMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'es',
                  child: Text('Español'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _language = value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notificações',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Notificações ativadas'),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() => _notificationsEnabled = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoSaveCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Salvamento automático',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Salvamento automático ativado'),
              value: _autoSaveEnabled,
              onChanged: (value) {
                setState(() => _autoSaveEnabled = value);
              },
            ),
            if (_autoSaveEnabled) ...[
              const SizedBox(height: 16),
              Text(
                'Intervalo de salvamento (minutos)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Slider(
                value: _autoSaveInterval.toDouble(),
                min: 1,
                max: 30,
                divisions: 29,
                label: _autoSaveInterval.toString(),
                onChanged: (value) {
                  setState(() => _autoSaveInterval = value.toInt());
                },
              ),
              Text(
                'Salvar a cada $_autoSaveInterval minutos',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
