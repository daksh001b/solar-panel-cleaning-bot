import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar Panel Cleaning Bot',
      theme: ThemeData(

        //brightness: Brightness.dark,
        //primaryColor: Colors.lightBlue[800],

        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Solar Panel Cleaning Bot'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('assets/solar_panel.png'),
            SizedBox(height: 10),
            const Text(
            'Ready to clean!',
                style: TextStyle(
                  fontSize: 16,
                )
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: (){print("Container clicked");},
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 10,
                      color: Colors.indigo,
                    ),
                ),
                child: Center(
                  child: const Text(
                    'CLEAN',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.indigo,

                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
