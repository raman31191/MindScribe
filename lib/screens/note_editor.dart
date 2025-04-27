import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

class NoteEditor extends StatefulWidget {
  final models.Document? note;
  final Function(String title, String content, bool isPublic)? onSave;
  final bool isGuest;

  const NoteEditor({
    super.key,
    this.note,
    this.onSave,
    required this.isGuest, // Add this line
  });

  @override
  _NotesEditingScreenState createState() => _NotesEditingScreenState();
}

class _NotesEditingScreenState extends State<NoteEditor> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _isPublic = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.data['title'];
      _contentController.text = widget.note!.data['content'];
      _isPublic = widget.note!.data['isPublic'] ?? false;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(labelText: 'Content'),
            maxLines: 3,
          ),
          Row(
            children: [
              const Text('Public'),
              Switch(
                value: _isPublic,
                onChanged: widget.isGuest
                    ? null // ✅ Guests cannot toggle private notes
                    : (value) {
                        setState(() {
                          _isPublic = value;
                        });
                      },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (_titleController.text.isNotEmpty &&
                _contentController.text.isNotEmpty) {
              widget.onSave?.call(
                _titleController.text,
                _contentController.text,
                _isPublic,
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
