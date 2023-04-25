import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solar_panel_cleaning_bot/functionality/database.dart';
import 'package:solar_panel_cleaning_bot/functionality/auth.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton.icon(
              onPressed: () async{
                await AuthService().googleSignIn();
              },
              icon: Icon(Icons.g_mobiledata_rounded),
              label: const Text("Log in with Google!"),
            )
        )
    );
  }
}