import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../features/auth/services/auth_service.dart';

class AyaDrawer extends StatelessWidget {
  final AuthService authService;

  const AyaDrawer({
    super.key,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {
    final user = authService.getCurrentUser();
    final isAdmin = user?.userMetadata?['role'] == 'admin';

    return Drawer(
      backgroundColor: AyaColors.surface,
      child: Column(
        children: [
          _buildDrawerHeader(context, user),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'Meu Perfil',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.favorite_border,
                  title: 'Curtidas',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/favorites');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.note_alt_outlined,
                  title: 'Anotações',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/notes');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.card_membership,
                  title: 'Planos & Assinaturas',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/subscription');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings_outlined,
                  title: 'Configurações do App',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                if (isAdmin)
                  _buildDrawerItem(
                    context,
                    icon: Icons.bolt_outlined,
                    title: 'Painel do Admin',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/admin');
                    },
                  ),
                const Divider(color: AyaColors.lavenderSoft30),
                _buildContinueFromWhereYouLeftOff(context),
                const Divider(color: AyaColors.lavenderSoft30),
                _buildDrawerItem(
                  context,
                  icon: Icons.logout,
                  title: 'Sair',
                  onTap: () async {
                    await authService.signOut();
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context, User? user) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AyaColors.background,
            AyaColors.surface,
          ],
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AyaColors.lavenderSoft,
            child: user?.userMetadata?['avatar_url'] != null
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user!.userMetadata!['avatar_url'],
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                      placeholder: (context, url) => const Icon(
                        Icons.person,
                        size: 40,
                        color: AyaColors.textPrimary,
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        size: 40,
                        color: AyaColors.textPrimary,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 40,
                    color: AyaColors.textPrimary,
                  ),
          ),
          const SizedBox(height: 16),
          Text(
            user?.userMetadata?['name'] ?? 'Usuário',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AyaColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            user?.userMetadata?['email'] ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AyaColors.textPrimary60,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AyaColors.lavenderVibrant,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AyaColors.textPrimary,
            ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildContinueFromWhereYouLeftOff(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Continue de onde parou',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AyaColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AyaColors.lavenderSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/200',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AyaColors.lavenderSoft,
                    child: const Icon(
                      Icons.play_circle_outline,
                      color: AyaColors.textPrimary,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AyaColors.lavenderSoft,
                    child: const Icon(
                      Icons.play_circle_outline,
                      color: AyaColors.textPrimary,
                    ),
                  ),
                ),
              ),
              title: Text(
                'Introdução à Meditação',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AyaColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              subtitle: Text(
                'Módulo: Mindfulness • Aula 1',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AyaColors.textPrimary60,
                    ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/lesson/1');
              },
            ),
          ),
        ],
      ),
    );
  }
}
