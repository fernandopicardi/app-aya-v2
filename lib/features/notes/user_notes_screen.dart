import 'package:flutter/material.dart';
import 'package:app_aya_v2/services/notes_service.dart';

class UserNotesScreen extends StatefulWidget {
  const UserNotesScreen({super.key});

  @override
  State<UserNotesScreen> createState() => _UserNotesScreenState();
}

class _UserNotesScreenState extends State<UserNotesScreen> {
  late Future<List<Map<String, dynamic>>> _notesFuture;
  final _service = NotesService();
  bool _isLoading = false;
  String? _errorMessage;
  final _noteController = TextEditingController();
  String? _editingNoteId;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() {
    setState(() {
      _notesFuture = _service.getNotes();
    });
  }

  Future<void> _addNote() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await _service.addNote('content_id_mock', _noteController.text.trim());
      _noteController.clear();
      _loadNotes();
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao adicionar anotação';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _removeNote(String noteId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await _service.removeNote(noteId);
      _loadNotes();
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao remover anotação';
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
      appBar: AppBar(title: const Text('Minhas Anotações')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      labelText: 'Nova anotação',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isLoading ? null : _addNote,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Adicionar'),
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
          if (_editingNoteId != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Editando nota: $_editingNoteId',
                  style: const TextStyle(color: Colors.blue)),
            ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _notesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    _isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Erro ao carregar anotações: ${snapshot.error}'));
                }
                final notes = snapshot.data ?? [];
                if (notes.isEmpty) {
                  return const Center(child: Text('Nenhuma anotação ainda.'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: notes.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return ListTile(
                      leading: const Icon(Icons.note, color: Colors.teal),
                      title: Text(note['note_text']),
                      subtitle: Text('Atualizado em: ${note['updated_at']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _editingNoteId = note['id'].toString();
                              _noteController.text = note['note_text'];
                            },
                            tooltip: 'Editar',
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeNote(note['id'].toString()),
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
