class WaterIntake {
  final String userId;
  final String date;
  final int totalIntake;

  WaterIntake(
      {required this.userId, required this.date, required this.totalIntake});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date,
      'totalIntake': totalIntake,
    };
  }

//Here, the fromMap factory constructor takes a Map (like JSON data) and returns a WaterIntake object.
// This is useful when converting data from a database (like Appwrite, Firebase, etc.) into your Dart class.
  factory WaterIntake.fromMap(Map<String, dynamic> map) {
    return WaterIntake(
      userId: map['userId'],
      date: map['date'],
      totalIntake: map['totalIntake'],
    );
  }
}
