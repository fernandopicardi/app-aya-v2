import 'package:flutter/material.dart';

class AdminMenu extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  const AdminMenu({super.key, required this.selectedIndex, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.dashboard, 'label': 'Dashboard'},
      {'icon': Icons.people, 'label': 'Usuários'},
      {'icon': Icons.menu_book, 'label': 'Conteúdo'},
      {'icon': Icons.comment, 'label': 'Moderação'},
      {'icon': Icons.emoji_events, 'label': 'Gamificação'},
      {'icon': Icons.list_alt, 'label': 'Logs'},
      {'icon': Icons.settings, 'label': 'Configurações'},
    ];
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 48),
          const Text('Painel Admin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 24),
          ...List.generate(items.length, (i) => ListTile(
            leading: Icon(items[i]['icon'] as IconData),
            title: Text(items[i]['label'] as String),
            selected: i == selectedIndex,
            onTap: () => onItemSelected(i),
          )),
          const Spacer(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('© 2024 App Aya', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ),
        ],
      ),
    );
  }
} 