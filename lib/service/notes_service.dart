import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class NotesService {
  final Databases _databases;
  final String _databaseId = '67caef3700110ee0cda9';
  final String _collectionId = '67caf008003e21c3b2a2';

  NotesService(Client client) : _databases = Databases(client);

  // Create a new note (public or private)
  Future<models.Document> createNote({
    required String title,
    required String content,
    required bool isPublic,
    required String userId,
  }) async {
    return await _databases.createDocument(
      databaseId: _databaseId,
      collectionId: _collectionId,
      documentId: ID.unique(),
      data: {
        "title": title,
        "content": content,
        "isPublic": isPublic,
        "userId": userId,
        "createdAt": DateTime.now().toIso8601String(),
      },
      permissions: [
        // Private note: Only owner can read/write
        Permission.read(Role.user(userId)),
        Permission.write(Role.user(userId)),
        // Public note: Everyone can read, but only owner can edit
        if (isPublic) Permission.read(Role.any()),
        if (isPublic) Permission.update(Role.user(userId)),
        if (isPublic) Permission.delete(Role.user(userId)),
      ],
    );
  }

  // Fetch public notes
  Future<models.DocumentList> getPublicNotes() async {
    return await _databases.listDocuments(
      databaseId: _databaseId,
      collectionId: _collectionId,
      queries: [
        Query.equal('isPublic', true),
        Query.orderDesc('createdAt'),
      ],
    );
  }

  // Fetch private notes for the logged-in user
  Future<models.DocumentList> getUserNotes(String userId) async {
    return await _databases.listDocuments(
      databaseId: _databaseId,
      collectionId: _collectionId,
      queries: [
        Query.equal('userId', userId),
        Query.equal('isPublic', false),
        Query.orderDesc('createdAt'),
      ],
    );
  }

  // Update a note (only by the creator)
  Future<void> updateNote({
    required String documentId,
    required String title,
    required String content,
  }) async {
    await _databases.updateDocument(
      databaseId: _databaseId,
      collectionId: _collectionId,
      documentId: documentId,
      data: {
        "title": title,
        "content": content,
      },
    );
  }

  // Delete a note (only by the creator)
  Future<void> deleteNote(String documentId) async {
    await _databases.deleteDocument(
      databaseId: _databaseId,
      collectionId: _collectionId,
      documentId: documentId,
    );
  }
}
