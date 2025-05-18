import 'package:flutter/material.dart';
import 'package:app_aya_v2/services/favorites_service.dart';

class UserFavoritesScreen extends StatefulWidget {
  const UserFavoritesScreen({super.key});

  @override
  State<UserFavoritesScreen> createState() => _UserFavoritesScreenState();
}

class _UserFavoritesScreenState extends State<UserFavoritesScreen> {
  late Future<List<Map<String, dynamic>>> _favoritesFuture;
  final _service = FavoritesService();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      _favoritesFuture = _service.getFavorites();
    });
  }

  Future<void> _removeFavorite(String favoriteId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await _service.removeFavorite(favoriteId);
      _loadFavorites();
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao remover favorito';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Favoritos')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              _isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || _errorMessage != null) {
            return Center(
                child: Text(_errorMessage ?? 'Erro ao carregar favoritos'));
          }
          final favorites = snapshot.data ?? [];
          if (favorites.isEmpty) {
            return const Center(child: Text('Nenhum favorito ainda.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final fav = favorites[index];
              return ListTile(
                leading: const Icon(Icons.favorite, color: Colors.purple),
                title: Text('Conteúdo: ${fav['content_id']}'),
                subtitle: Text('Adicionado em: ${fav['created_at']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeFavorite(fav['id'].toString()),
                  tooltip: 'Remover',
                ),
                onTap: () {
                  // TODO: Navegar para o conteúdo favoritado
                },
              );
            },
          );
        },
      ),
    );
  }
}
