import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:appwrite/appwrite.dart';
import 'package:mental_health/constants.dart';
import 'package:path_provider/path_provider.dart';

class UploadProfilePictureScreen extends StatefulWidget {
  const UploadProfilePictureScreen({super.key});

  @override
  State<UploadProfilePictureScreen> createState() =>
      _UploadProfilePictureScreenState();
}

class _UploadProfilePictureScreenState
    extends State<UploadProfilePictureScreen> {
  final Client client = Client();
  late Storage storage;
  late Account account;
  late Databases databases;

  final String endpoint = AppwriteConstants.endpoint;
  final String projectId = AppwriteConstants.projectId;
  final String bucketId = AppwriteConstants.bucketId;
  final String databaseId = AppwriteConstants.databaseId;
  final String collectionId = AppwriteConstants.collectionId;

  bool _isLoading = false;
  Uint8List? _profileImageBytes;

  @override
  void initState() {
    super.initState();
    client
      ..setEndpoint(endpoint)
      ..setProject(projectId)
      ..setSelfSigned(status: true);

    storage = Storage(client);
    account = Account(client);
    databases = Databases(client);

    _loadProfileImage();
  }

  Future<File?> _pickAndResizeImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final bytes = await pickedFile.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return null;

    // Resize to 120x120
    final resized = img.copyResize(image, width: 120, height: 120);
    final resizedBytes = Uint8List.fromList(img.encodeJpg(resized));

    // Save resized image to temp file
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/resized_profile.jpg');
    await tempFile.writeAsBytes(resizedBytes);
    return tempFile;
  }

  Future<String?> _uploadImage(File file, String userId) async {
    try {
      final result = await storage.createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path),
        permissions: [
          Permission.read(Role.user(userId)),
          Permission.write(Role.user(userId)),
        ],
      );
      return result.$id;
    } catch (e) {
      debugPrint('❌ Upload failed: $e');
      return null;
    }
  }

  Future<void> _saveFileIdToDatabase(String userId, String fileId) async {
    try {
      final docs = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [Query.equal('userId', userId)],
      );

      if (docs.documents.isNotEmpty) {
        final documentId = docs.documents.first.$id;
        await databases.updateDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId,
          data: {'profilePic': fileId},
        );
      } else {
        await databases.createDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: ID.unique(),
          data: {
            'userId': userId,
            'profilePic': fileId,
          },
        );
      }
    } catch (e) {
      debugPrint('❌ Error saving file ID to DB: $e');
    }
  }

  Future<void> _loadProfileImage() async {
    try {
      final user = await account.get();
      final userId = user.$id;

      final result = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [Query.equal('userId', userId)],
      );

      if (result.documents.isNotEmpty) {
        final fileId = result.documents.first.data['profilePic'];
        final bytes = await storage.getFilePreview(
          bucketId: bucketId,
          fileId: fileId,
          width: 120,
          height: 120,
        );
        setState(() {
          _profileImageBytes = bytes;
        });
      }
    } catch (e) {
      debugPrint('❌ Error loading profile image: $e');
    }
  }

  Future<void> _handleUpload() async {
    try {
      setState(() => _isLoading = true);

      final imageFile = await _pickAndResizeImage();
      if (imageFile == null) {
        setState(() => _isLoading = false);
        return;
      }

      final user = await account.get();
      final userId = user.$id;

      final fileId = await _uploadImage(imageFile, userId);
      if (fileId == null) {
        setState(() => _isLoading = false);
        return;
      }

      await _saveFileIdToDatabase(userId, fileId);
      await _loadProfileImage();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Profile image uploaded!')),
      );
      await _saveFileIdToDatabase(userId, fileId);
      await _loadProfileImage();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Profile image uploaded!')),
      );

      Navigator.pop(context);
    } catch (e) {
      debugPrint('❌ Unexpected Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Profile Picture')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_profileImageBytes != null)
                    ClipOval(
                      child: Image.memory(
                        _profileImageBytes!,
                        key: UniqueKey(),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const CircleAvatar(
                      radius: 60,
                      child: Icon(Icons.person, size: 50),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.upload),
                    label: const Text('Pick & Upload'),
                    onPressed: _handleUpload,
                  ),
                ],
              ),
      ),
    );
  }
}
