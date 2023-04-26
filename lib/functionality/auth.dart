import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:solar_panel_cleaning_bot/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:solar_panel_cleaning_bot/functionality/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> saveUserId(String? token) async {
    await storage.write(key: 'userId', value: token);
  }

  Future<String?> getUserId() async {
    return await storage.read(key: 'userId');
  }

  Future<void> deleteUserId() async {
    storage.delete(key: 'userId');
  }

  Future<void> saveEmail(String? token) async {
    await storage.write(key: 'email', value: token);
  }

  Future<String?> getEmail() async {
    return await storage.read(key: 'email');
  }

  Future<void> deleteEmail() async {
    storage.delete(key: 'email');
  }

  Future<void> saveDisplayName(String? token) async {
    await storage.write(key: 'displayName', value: token);
  }

  Future<String?> getDisplayName() async {
    return await storage.read(key: 'displayName');
  }

  Future<void> deleteDisplayName() async {
    storage.delete(key: 'displayName');
  }

  Future<void> deleteSecureStorage() async {
    storage.deleteAll();
  }

  Future<Map<String, String>> googleSignIn() async {
    GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? gAuth = await gUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken, idToken: gAuth?.idToken);

    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    print(
        "--------------------inside google sign in func---------------------");
    final user = userCredential.user!;
    print(user);
    return {
      "uid": user.uid,
      "email": user.email!,
      "displayName": user.displayName!
    };
    // await DatabaseService.setupDatabase(user.uid, user.email!, user.displayName!);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
