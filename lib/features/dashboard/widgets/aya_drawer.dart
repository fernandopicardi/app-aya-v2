import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../features/auth/services/auth_service.dart';

class AyaDrawer extends StatefulWidget {
  final AuthService authService;
  final bool isAdmin;

  const AyaDrawer({
    super.key,
    required this.authService,
    this.isAdmin = false,
  });

  @override
  State<AyaDrawer> createState() => _AyaDrawerState();
}

class _AyaDrawerState extends State<AyaDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = widget.authService.getCurrentUser();
    final isAdmin = user?.userMetadata?['role'] == 'admin';

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Drawer(
          backgroundColor: AyaColors.surface.withOpacity(0.8),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AyaColors.surface.withOpacity(0.9),
                  AyaColors.surface.withOpacity(0.7),
                ],
              ),
              border: Border(
                right: BorderSide(
                  color: AyaColors.lavenderVibrant.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                _buildHeader(user),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildMenuItem(
                        icon: Icons.home_outlined,
                        selectedIcon: Icons.home,
                        label: 'Home',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.library_books_outlined,
                        selectedIcon: Icons.library_books,
                        label: 'Biblioteca',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.people_outline,
                        selectedIcon: Icons.people,
                        label: 'Comunidade',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.smart_toy_outlined,
                        selectedIcon: Icons.smart_toy,
                        label: 'Aya Chat',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Divider(
                        color: AyaColors.lavenderSoft,
                        height: 32,
                      ),
                      if (isAdmin)
                        _buildMenuItem(
                          icon: Icons.admin_panel_settings_outlined,
                          selectedIcon: Icons.admin_panel_settings,
                          label: 'Admin',
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      _buildMenuItem(
                        icon: Icons.settings_outlined,
                        selectedIcon: Icons.settings,
                        label: 'Configurações',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.help_outline,
                        selectedIcon: Icons.help,
                        label: 'Ajuda',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.logout,
                        selectedIcon: Icons.logout,
                        label: 'Sair',
                        onTap: () async {
                          await widget.authService.signOut();
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(User? user) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AyaColors.lavenderVibrant.withOpacity(0.2),
            AyaColors.turquoise.withOpacity(0.2),
          ],
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AyaColors.lavenderVibrant.withOpacity(0.2),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: user?.userMetadata?['avatar_url'] ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AyaColors.lavenderSoft,
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: AyaColors.textPrimary,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AyaColors.lavenderSoft,
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: AyaColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user?.userMetadata?['full_name'] ?? 'Usuário AYA',
            style: const TextStyle(
              color: AyaColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user?.email ?? '',
            style: TextStyle(
              color: AyaColors.textPrimary.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AyaColors.lavenderVibrant.withOpacity(0.1),
                      AyaColors.turquoise.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AyaColors.textPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  color: AyaColors.textPrimary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
