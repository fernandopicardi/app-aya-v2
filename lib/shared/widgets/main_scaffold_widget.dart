import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

class MainScaffoldWidget extends StatefulWidget {
  final Widget child;

  const MainScaffoldWidget({super.key, required this.child});

  @override
  State<MainScaffoldWidget> createState() => _MainScaffoldWidgetState();
}

class _MainScaffoldWidgetState extends State<MainScaffoldWidget> {
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRouteNames.home)) return 0;
    if (location.startsWith(AppRouteNames.library)) return 1;
    if (location.startsWith(AppRouteNames.community)) return 2;
    if (location.startsWith(AppRouteNames.chatIA)) return 3;
    return 0; // Default to home
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).goNamed(AppRouteNames.home);
        break;
      case 1:
        GoRouter.of(context).goNamed(AppRouteNames.library);
        break;
      case 2:
        GoRouter.of(context).goNamed(AppRouteNames.community);
        break;
      case 3:
        GoRouter.of(context).goNamed(AppRouteNames.chatIA);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Text(
                'App Aya Menu',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            ListTile(
              leading: const iconoir.User(),
              title: const Text('Meu Perfil'),
              onTap: () {
                Navigator.pop(context);
                GoRouter.of(context).pushNamed(AppRouteNames.userProfile);
              },
            ),
            ListTile(
              leading: const iconoir.Settings(),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to settings
              },
            ),
            ListTile(
              leading: const iconoir.LogOut(),
              title: const Text('Sair'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement logout and navigate to login
                GoRouter.of(context).goNamed(AppRouteNames.login);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: iconoir.Home(), label: 'Início'),
          BottomNavigationBarItem(
            icon: iconoir.BookStack(),
            label: 'Biblioteca',
          ),
          BottomNavigationBarItem(
            icon: iconoir.Community(),
            label: 'Comunidade',
          ),
          BottomNavigationBarItem(
            icon: iconoir.ChatBubbleQuestion(),
            label: 'Chat IA',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }
}
