import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:solar_panel_cleaning_bot/Pages/bot_list_filler.dart';
import 'package:solar_panel_cleaning_bot/blocs/bloc/auth.dart';
import 'package:solar_panel_cleaning_bot/functionality/auth.dart';
import 'package:solar_panel_cleaning_bot/functionality/database.dart';
import 'package:solar_panel_cleaning_bot/models/bot.dart';

class BotList extends StatefulWidget {
  @override
  State<BotList> createState() => _BotList();
}

class _BotList extends State<BotList> {
  @override
  Widget build(BuildContext context) {

    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text(
    //         'Bots',
    //         style: TextStyle(
    //           fontSize: 25,
    //           //fontFamily: 'Bebas Neue',
    //           color: Colors.white,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       titleSpacing: 20,
    //       backgroundColor: Colors.indigo,
    //       actions: <Widget>[
    //         IconButton(
    //             icon: Icon(
    //               Icons.person,
    //               color: Colors.white,
    //             ),
    //             onPressed: () async {
    //               //await AuthService().signOut();
    //               BlocProvider.of<AuthBloc>(context).add(AuthGoogleLogoutEvent());
    //             }),
    //       ],
    //     ),
    // );

    return StreamProvider<List<Bot>>.value(
    initialData: [Bot("bot1", "name","description", DateTime.now())],
    value: DatabaseService().bots,
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Bots',
          style: TextStyle(
            fontSize: 25,
            //fontFamily: 'Bebas Neue',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 20,
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () async {
                //await AuthService().signOut();
                BlocProvider.of<AuthBloc>(context).add(AuthGoogleLogoutEvent());
              }),
        ],
      ),
      body: const BotListFiller(),
    ),
    );
  }
}
