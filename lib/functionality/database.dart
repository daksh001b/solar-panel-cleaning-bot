import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solar_panel_cleaning_bot/models/user.dart';
import 'package:solar_panel_cleaning_bot/models/bot.dart';

class DatabaseService {
  static late User user;
  static final db = FirebaseFirestore.instance;

  static Future<void> setupDatabase(
      String uid, String email, String name) async {
    print("-----------------inside setupdatabase func-----------------------");

    db.collection('users').doc(uid).get().then((DocumentSnapshot doc) => {
          if (!doc.exists)
            {
              print(
                  "-----------------creating new user-----------------------"),
              db
                  .collection('users')
                  .doc(uid)
                  .set({"name": name, "email": email, "bots": []}),
            }
        });

    final usersRef = db.collection('users').doc(uid);
    usersRef.get().then(
      (DocumentSnapshot doc) {
        print("-------------------fetching user---------------------");
        final data = doc.data() as Map<String, dynamic>;
        user = User(data['name'], data['email'], data['bots']);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Stream<List<Bot>> get bots {
    List<String> botIdArray = user.bots;
    CollectionReference botCollection = db.collection("bots")
      ..where(FieldPath.documentId, whereIn: botIdArray);

    return botCollection.snapshots().map(_botListFromSnapshot);
  }

  List<Bot> _botListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Bot(
        data['name'] ?? '',
        data['description'] ?? '',
        data['lastCleaned'] != null ? data['lastCleaned'].toDate() : null,
      );
    }).toList();
  }
}
