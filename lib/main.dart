import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:solar_panel_cleaning_bot/Pages/bot_status.dart';
import 'Pages/bot_status2.dart';
import 'Pages/login_page.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  runApp(Home());
}

class Home extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar Panel Cleaning Bot',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.active ) {
            if (snapshot.data == null) {
              return Login();
            }

          else {
            return BotStatus2();
          }
        }
            return Center(child: CircularProgressIndicator());
    }
        //}
      ),
      // routes: {
      //   //'/': (context) => BotStatus(),
      //   '/': (context) => Login(),
      // },
    );
  }

}
