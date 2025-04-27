import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:mental_health/screens/note_editor.dart';
import 'package:mental_health/service/notes_service.dart';
import 'package:mental_health/service/auth_service.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late final Client client;
  late final NotesService _notesService;
  final AuthService _authService = AuthService();
  String? _userId;
  bool _isGuest = true;

  @override
  void initState() {
    super.initState();
    client = Client()
      ..setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite endpoint
      ..setProject('67b199c1000934958d6a'); // Your Project ID

    _notesService = NotesService(client);
    _loadUserId();
  }

  void _deleteNoteConfirmation(String noteId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text(
            'Are you sure you want to delete this note? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _notesService.deleteNote(noteId);
              setState(() {}); // Refresh UI after deletion
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _loadUserId() async {
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        setState(() {
          _userId = user.$id;
          _isGuest = false;
        });
      } else {
        setState(() {
          _isGuest = true;
        });
      }
    } catch (e) {
      print('Error fetching user ID: $e');
      setState(() {
        _isGuest = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _isGuest ? 1 : 2, // Set tab count based on user type
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          bottom: _isGuest
              ? null
              : const TabBar(
                  tabs: [
                    Tab(text: 'Public Notes'),
                    Tab(text: 'My Notes'),
                  ],
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showCreateNoteDialog,
          child: const Icon(Icons.add),
        ),
        body: _isGuest
            ? _buildNotesList(() => _notesService.getPublicNotes(),
                isPublic: true)
            : TabBarView(
                children: [
                  // Public Notes Tab
                  _buildNotesList(() => _notesService.getPublicNotes(),
                      isPublic: true),

                  // My Notes Tab
                  _buildNotesList(() => _notesService.getUserNotes(_userId!),
                      isPublic: false),
                ],
              ),
      ),
    );
  }

  Widget _buildNotesList(Future<models.DocumentList> Function() fetchNotes,
      {required bool isPublic}) {
    return FutureBuilder<models.DocumentList>(
      future: fetchNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.documents.isEmpty) {
          return Center(
              child: Text(isPublic
                  ? 'No public notes found.'
                  : 'No private notes found.'));
        }

        final notes = snapshot.data!.documents;
        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            final isUserNote = note.data['userId'] == _userId;
            bool isLiked = false; // Local state

            return Dismissible(
              key: Key(note.$id),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              direction: isUserNote && !_isGuest
                  ? DismissDirection.endToStart
                  : DismissDirection.none,
              onDismissed: isUserNote && !_isGuest
                  ? (direction) {
                      _deleteNoteConfirmation(note.$id);
                    }
                  : null,
              child: StatefulBuilder(
                builder: (context, setHeartState) {
                  return Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      title: Text(
                        note.data['title'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          note.data['content'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setHeartState(() {
                            isLiked = !isLiked;
                          });
                        },
                      ),
                      onTap: () {
                        if (_isGuest) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteEditor(
                              note: note,
                              isGuest: _isGuest,
                              onSave: (title, content, isPublic) async {
                                await _notesService.updateNote(
                                  documentId: note.$id,
                                  title: title,
                                  content: content,
                                );
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void _showCreateNoteDialog() {
    showDialog(
      context: context,
      builder: (context) => NoteEditor(
        isGuest: _isGuest,
        onSave: (title, content, isPublic) async {
          await _notesService.createNote(
            title: title,
            content: content,
            isPublic: isPublic,
            userId: _userId ?? 'guest',
          );
          setState(() {});
        },
      ),
    );
  }
}
