import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
              onPressed: () {
                googleSignIn();
              }, child: const Text("Log in with Google!"),
            )
        )
    );
  }

  googleSignIn() async {
    GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? gAuth = await gUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken,
        idToken: gAuth?.idToken
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    print(userCredential.user?.displayName);
  }


}