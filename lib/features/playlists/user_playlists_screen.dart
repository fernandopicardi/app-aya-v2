import 'package:flutter/material.dart';
import 'package:app_aya_v2/services/playlists_service.dart';

class UserPlaylistsScreen extends StatefulWidget {
  const UserPlaylistsScreen({super.key});

  @override
  State<UserPlaylistsScreen> createState() => _UserPlaylistsScreenState();
}

class _UserPlaylistsScreenState extends State<UserPlaylistsScreen> {
  late Future<List<Map<String, dynamic>>> _playlistsFuture;
  final _service = PlaylistsService();
  bool _isLoading = false;
  String? _errorMessage;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _editingPlaylistId;

  @override
  void initState() {
    super.initState();
    _loadPlaylists();
  }

  void _loadPlaylists() {
    setState(() {
      _playlistsFuture = _service.getPlaylists();
    });
  }

  Future<void> _addPlaylist() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await _service.addPlaylist(
          _nameController.text.trim(), _descriptionController.text.trim());
      _nameController.clear();
      _descriptionController.clear();
      _loadPlaylists();
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao adicionar playlist';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _removePlaylist(String playlistId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await _service.removePlaylist(playlistId);
      _loadPlaylists();
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao remover playlist';
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
      appBar: AppBar(title: const Text('Minhas Playlists')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome da Playlist',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isLoading ? null : _addPlaylist,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Adicionar Playlist'),
                ),
              ],
            ),
          ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_errorMessage!,
                  style: const TextStyle(color: Colors.red)),
            ),
          if (_editingPlaylistId != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Editando playlist: $_editingPlaylistId',
                  style: const TextStyle(color: Colors.blue)),
            ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _playlistsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    _isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Erro ao carregar playlists: ${snapshot.error}'));
                }
                final playlists = snapshot.data ?? [];
                if (playlists.isEmpty) {
                  return const Center(child: Text('Nenhuma playlist ainda.'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: playlists.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return ListTile(
                      leading:
                          const Icon(Icons.playlist_play, color: Colors.blue),
                      title: Text(playlist['name']),
                      subtitle: Text(playlist['description']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _editingPlaylistId = playlist['id'].toString();
                              _nameController.text = playlist['name'];
                              _descriptionController.text =
                                  playlist['description'];
                            },
                            tooltip: 'Editar',
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _removePlaylist(playlist['id'].toString()),
                            tooltip: 'Remover',
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
