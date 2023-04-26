import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solar_panel_cleaning_bot/Pages/bot_list.dart';
import 'package:solar_panel_cleaning_bot/blocs/bloc/auth_bloc.dart';
import 'package:solar_panel_cleaning_bot/blocs/bloc/auth_event.dart';
import 'package:solar_panel_cleaning_bot/functionality/database.dart';
import 'package:solar_panel_cleaning_bot/functionality/auth.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton.icon(
      onPressed: () async {
        BlocProvider.of<AuthBloc>(context).add(AuthGoogleLoginEvent());
        // await AuthService().googleSignIn();
      },
      icon: Icon(Icons.g_mobiledata_rounded),
      label: const Text("Log in with Google!"),
    )));
  }
}
