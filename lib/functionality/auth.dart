import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_core/firebase_core.dart';
import 'package:solar_panel_cleaning_bot/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:solar_panel_cleaning_bot/functionality/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  googleSignIn() async {
    GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? gAuth = await gUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken,
        idToken: gAuth?.idToken
    );

    UserCredential userCredential = await _auth.signInWithCredential(credential);
    print("--------------------inside google sign in func---------------------");
    final user = userCredential.user!;
    print(user);
    await DatabaseService.setupDatabase(user.uid, user.email!, user.displayName!);
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