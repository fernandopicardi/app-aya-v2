import 'package:flutter/material.dart';
import 'package:app_aya_v2/features/auth/auth_service.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:app_aya_v2/features/favorites/user_favorites_screen.dart';
import 'package:app_aya_v2/features/notes/user_notes_screen.dart';
import 'package:app_aya_v2/features/playlists/user_playlists_screen.dart';
import 'package:app_aya_v2/features/subscription/subscription_screen.dart';
import 'package:app_aya_v2/features/legal/terms_page.dart';
import 'package:app_aya_v2/features/legal/privacy_page.dart';
import 'package:app_aya_v2/features/legal/faq_page.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isEditing = false;
  bool _isLoading = false;
  String? _avatarUrl;
  File? _newAvatar;
  Uint8List? _newAvatarBytes;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    try {
      final profile = await AuthService().getCurrentUserProfile();
      if (profile != null) {
        _nameController.text = profile['name'] ?? '';
        _emailController.text = profile['email'] ?? '';
        _avatarUrl = profile['avatar_url'];
      }
    } catch (e) {
      setState(() => _errorMessage = 'Erro ao carregar perfil');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      String? avatarUrl = _avatarUrl;
      if (_newAvatarBytes != null) {
        final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final response =
            await AuthService().uploadAvatar(_newAvatarBytes!, fileName);
        avatarUrl = response;
      }
      await AuthService().updateUserProfile(
        name: _nameController.text.trim(),
        avatarUrl: avatarUrl,
      );
      if (!mounted) return;
      setState(() {
        _isEditing = false;
        _avatarUrl = avatarUrl;
        _newAvatar = null;
        _newAvatarBytes = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado!')),
      );
    } catch (e) {
      setState(() => _errorMessage = 'Erro ao salvar perfil');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _newAvatar = File(picked.path);
        _newAvatarBytes = bytes;
      });
    }
  }

  Future<void> _logout() async {
    await AuthService().signOut();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  void _showTermsOfUse() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TermsPage(),
      ),
    );
  }

  void _showPrivacyPolicy() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PrivacyPage(),
      ),
    );
  }

  void _showFAQ() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const FAQPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Sair',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 54,
                          backgroundImage: _newAvatar != null
                              ? FileImage(_newAvatar!)
                              : (_avatarUrl != null && _avatarUrl!.isNotEmpty)
                                  ? NetworkImage(_avatarUrl!) as ImageProvider
                                  : const AssetImage(
                                      'assets/avatar_placeholder.png'),
                        ),
                        if (_isEditing)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: _pickAvatar,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(51),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(8),
                                child:
                                    const Icon(Icons.edit, color: Colors.black),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _nameController,
                    enabled: _isEditing,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_errorMessage != null)
                    Text(_errorMessage!,
                        style: const TextStyle(color: Colors.redAccent)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!_isEditing)
                        ElevatedButton(
                          onPressed: () => setState(() => _isEditing = true),
                          child: const Text('Editar'),
                        ),
                      if (_isEditing)
                        ElevatedButton(
                          onPressed: _isLoading ? null : _saveProfile,
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Salvar'),
                        ),
                      if (_isEditing) const SizedBox(width: 16),
                      if (_isEditing)
                        OutlinedButton(
                          onPressed: () => setState(() => _isEditing = false),
                          child: const Text('Cancelar'),
                        ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Aqui você pode adicionar favoritos, anotações, playlists, badges, assinatura, etc.
                  // Exemplo:
                  ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.purple),
                    title: const Text('Meus Favoritos'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UserFavoritesScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.note, color: Colors.teal),
                    title: const Text('Minhas Anotações'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UserNotesScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.playlist_play, color: Colors.blue),
                    title: const Text('Minhas Playlists IA'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UserPlaylistsScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.verified_user, color: Colors.green),
                    title: const Text('Assinatura/Plano'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SubscriptionScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.emoji_events, color: Colors.orange),
                    title: const Text('Badges conquistados'),
                    subtitle: const Text('Em breve'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.description, color: Colors.blue),
                    title: const Text('Termos de Uso'),
                    onTap: _showTermsOfUse,
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip, color: Colors.green),
                    title: const Text('Política de Privacidade'),
                    onTap: _showPrivacyPolicy,
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.help_outline, color: Colors.orange),
                    title: const Text('Ajuda/FAQ'),
                    onTap: _showFAQ,
                  ),
                ],
              ),
            ),
    );
  }
}
