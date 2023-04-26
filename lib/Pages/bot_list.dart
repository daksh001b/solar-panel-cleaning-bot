import 'package:flutter/material.dart';
import 'package:solar_panel_cleaning_bot/functionality/auth.dart';

class BotList extends StatefulWidget {
  @override
  State<BotList> createState() => _BotList();
}

class _BotList extends State<BotList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bots',
          style: TextStyle(
            fontSize: 25,
            //fontFamily: 'Bebas Neue',
            color: Colors.amber,
          ),
        ),
        titleSpacing: 20,
        backgroundColor: Colors.black26,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.amber,
              ),
              onPressed: () async {
                await AuthService().signOut();
              }),
        ],
      ),
    );
  }
}
