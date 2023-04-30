import 'dart:async';
import 'package:flutter/material.dart';

import 'package:solar_panel_cleaning_bot/functionality/clean_operation.dart';
import 'package:firebase_database/firebase_database.dart';
import '../elements/loading.dart';
import 'package:solar_panel_cleaning_bot/functionality/auth.dart';

class BotStatus extends StatefulWidget {
  @override
  State<BotStatus> createState() => _BotStatus();
}

class _BotStatus extends State<BotStatus> {

  bool isLoadingPage = true;
  bool isLoadingButton = false;
  bool isCleaning = true;
  int minTempLastCleaned = 0, maxTempLastCleaned = 0;
  late int botId;
  late final _botRef;
  late StreamSubscription _botStatusStream;

  @override
  void initState({int botId = 1}) {
    super.initState();
    this.botId = botId;
    _botRef = FirebaseDatabase.instance.ref('bot' + botId.toString());


    updateIsCleaning();
  }

  void updateIsCleaning(){

    _botStatusStream = _botRef.onValue.listen((event) {

      print("event listner called!");
      if(event.snapshot.exists) {

        final map = Map<String, dynamic>.from(event.snapshot.value);
        setState(() {
          isCleaning = map['needsCleaning'];
          minTempLastCleaned = map['minTempLastCleaned'];
          maxTempLastCleaned = map['maxTempLastCleaned'];
          isLoadingPage = false;
        });
      }
      print(event.snapshot.value.toString() == 'true');
    });
  }

  void updateMinMaxTempLastCleaned(){

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: null,
      body: isLoadingPage ? Loading() :SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('assets/solar_panel.png'),
            SizedBox(height: 20),
            Text(
                isCleaning ? 'CLEANING AT THE MOMENT...': 'Ready to clean!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                )
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {

                if(!isCleaning){
                  setState(() {
                  isLoadingButton= true;
                  });
                  final result = await CleanOperation.cleanNow();
                  setState(() {
                  isLoadingButton= false;
                  isCleaning = result;
                  });
                }
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 10,
                    color: !isCleaning ? Colors.indigo : Colors.black26,
                  ),
                ),
                child: Center(
                    child: isLoadingButton ? Loading() : Text(
                      'CLEAN',
                      style: TextStyle(
                        fontSize: 35,
                        color: !isCleaning ? Colors.indigo : Colors.black26,
                      ),
                    )
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Column(
               children: [

                 Container(
                 height: 90,
                 width: 175,
                 decoration: BoxDecoration(
                   border: Border.all(
                     width: 2,
                     color: Colors.black26,
                   ),
                   borderRadius: BorderRadius.all(Radius.circular(20)),
                 ),
                 child: Center(
                     child: Text(
                       minTempLastCleaned == null ? '--' : minTempLastCleaned.toString() + ' °C',
                       style: TextStyle(
                         fontSize: 20,
                         color: Colors.black26,
                       ),
                     )
                 ),
                ),

                Text(
                  'min Temp'
                ),
              ]
             ),
            SizedBox(width: 20),
            Column(
              children: [
                Container(
                  height: 90,
                  width: 175,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.black26,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                      child: Text(
                        maxTempLastCleaned == null ? '--' : maxTempLastCleaned.toString() + ' °C',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black26,
                        ),
                      )
                  ),
                ),
                Text(
                    'max Temp'
                ),
              ],
            )
            ],
          ),
            ElevatedButton.icon(
              onPressed: () {
                AuthService().signOut();
              },
              icon: Icon(Icons.logout),
              label: const Text("Signout"),
            )
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _botStatusStream.cancel();
    super.deactivate();
  }
}
