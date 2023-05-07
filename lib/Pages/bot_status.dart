import 'dart:async';
import 'package:flutter/material.dart';

import 'package:solar_panel_cleaning_bot/functionality/clean_operation.dart';
import 'package:firebase_database/firebase_database.dart';
import '../elements/loading.dart';
import 'package:solar_panel_cleaning_bot/functionality/auth.dart';

class BotStatus extends StatefulWidget {
  final String botId;
  const BotStatus(this.botId);

  @override
  State<BotStatus> createState() => _BotStatus(botId);
}

class _BotStatus extends State<BotStatus> {
  _BotStatus(this.botId);
  bool isLoadingPage = true;
  bool isLoadingButton = false;
  bool isCleaning = true;
  int minTempLastCleaned = 0, maxTempLastCleaned = 0;
  String botId;
  late final _botRef;
  late StreamSubscription _botStatusStream;

  @override
  void initState() {
    super.initState();
    print("botId ------------------> " + botId);
    //this.botId = botId;
    _botRef = FirebaseDatabase.instance.ref(botId);

    updateIsCleaning();
  }

  void updateIsCleaning() {
    _botStatusStream = _botRef.onValue.listen((event) {
      print("event listner called!");
      if (event.snapshot.exists) {
        final map = Map<String, dynamic>.from(event.snapshot.value);
        setState(() {
          isCleaning = map['needsCleaning'];
          isLoadingPage = false;
        });
      }
      print(event.snapshot.value.toString() == 'true');
    });
  }

  void updateMinMaxTempLastCleaned() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: isLoadingPage
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/solar_panel.png'),
                  SizedBox(height: 20),
                  Text(
                      isCleaning
                          ? 'CLEANING AT THE MOMENT...'
                          : 'Ready to clean!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      if (!isCleaning) {
                        setState(() {
                          isLoadingButton = true;
                        });
                        final result = await CleanOperation.cleanNow(botId);
                        setState(() {
                          isLoadingButton = false;
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
                          child: isLoadingButton
                              ? Loading()
                              : Text(
                                  'CLEAN',
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: !isCleaning
                                        ? Colors.indigo
                                        : Colors.black26,
                                  ),
                                )),
                    ),
                  ),
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
