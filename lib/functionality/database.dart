import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solar_panel_cleaning_bot/models/bot.dart';

class DatabaseService {
  static String? uid;
  static String? name, email;
  static final db = FirebaseFirestore.instance;

  void setupDatabase(String setUid, String setEmail, String setName) {
    print("-----------------inside setupdatabase func-----------------------");

    uid = setUid;
    name = setEmail;
    email = setName;
  }

  Stream<List<Bot>> get bots {
    // if(uid==null){
    //   return Stream.empty();
    // }
    print("inside get bots func-------------");
    print(uid);
    print(name);
    print(email);
    var xx;
    List<dynamic> botIdArray = [];
    if (uid != null) {
      db.collection("users").doc(uid).get().then((DocumentSnapshot doc) => {
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
          botIdArray = data["bots"];
          print("botIdArray--------------->");
          print(botIdArray);
          CollectionReference botCollection = db.collection("bots")
            ..where(FieldPath.documentId, whereIn: botIdArray);

          xx = botCollection.snapshots().map(_botListFromSnapshot);
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }

    if (botIdArray.isEmpty) {
      print(
          "-----------------------bodIdArray is empty-------------------------");
      return Stream.empty();
    }

    // CollectionReference botCollection = db.collection("bots")
    //   ..where(FieldPath.documentId, whereIn: botIdArray);

    // return botCollection.snapshots().map(_botListFromSnapshot);
    return xx;
  }

  List<Bot> _botListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Bot(
        doc.reference.id ?? '',
        data['name'] ?? '',
        data['description'] ?? '',
        data['lastCleaned'] != null ? data['lastCleaned'].toDate() : null,
      );
    }).toList();
  }
}
