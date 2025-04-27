import 'package:appwrite/appwrite.dart';

class WaterService {
  final Databases database;

  final String databaseId = '67caef3700110ee0cda9';
  final String collectionId = '6800d9020019b1461d43';

  WaterService(Client client) : database = Databases(client);

  Future<void> logWaterIntake(String userId, String date, int amount) async {
    print(
        "➡️ logWaterIntake called with: userId = $userId, date = $date, amount = $amount");

    try {
      print("📥 Checking if today's intake already exists...");

      final result = await database.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [
          Query.equal('userId', userId),
          Query.equal('date', date),
        ],
      );

      print("📄 Found ${result.documents.length} matching documents");

      if (result.documents.isNotEmpty) {
        final doc = result.documents.first;
        final currentAmount = doc.data['totalIntake'];
        final newAmount = currentAmount + amount;

        print(
            "🔄 Updating document ${doc.$id} | Current = $currentAmount → New = $newAmount");

        await database.updateDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: doc.$id,
          data: {'totalIntake': newAmount},
        );

        print("✅ Document updated successfully");
      } else {
        print("📘 No existing entry for today. Creating new document...");

        await database.createDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: ID.unique(),
          data: {
            'userId': userId,
            'date': date,
            'totalIntake': amount,
          },
          permissions: [
            Permission.read(Role.user(userId)),
            Permission.update(Role.user(userId)),
          ],
        );

        print("✅ New document created");
      }
    } catch (e) {
      print('❌ Exception in logWaterIntake: $e');
      rethrow;
    }
  }

  Future<int> getTodayWaterIntake(String userId, String date) async {
    print("➡️ getTodayWaterIntake called with: userId = $userId, date = $date");

    try {
      final result = await database.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [
          Query.equal('userId', userId),
          Query.equal('date', date),
        ],
      );

      print(
          "📄 Retrieved ${result.documents.length} documents for today's date");

      if (result.documents.isNotEmpty) {
        final intake = result.documents.first.data['totalIntake'];
        print("✅ Today's total intake = $intake ml");
        return intake;
      }

      print("📭 No intake logged yet for today");
      return 0;
    } catch (e) {
      print('❌ Exception in getTodayWaterIntake: $e');
      return 0;
    }
  }
}
