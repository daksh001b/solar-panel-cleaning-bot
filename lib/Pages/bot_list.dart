import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_panel_cleaning_bot/Pages/bot_status.dart';
import 'package:solar_panel_cleaning_bot/blocs/bloc/auth.dart';
import 'package:solar_panel_cleaning_bot/elements/loading.dart';

class BotList extends StatefulWidget {
  final String uid;
  BotList(this.uid);
  @override
  State<BotList> createState() => _BotList();
}

class _BotList extends State<BotList> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () async {
                //await AuthService().signOut();
                BlocProvider.of<AuthBloc>(context).add(AuthGoogleLogoutEvent());
              }),
        ],
      ),
      body: FutureBuilder(
        future: db.collection("users").doc(widget.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var botsId = snapshot.data?.data()?["bots"];
            return StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection('bots')
                  .where(FieldPath.documentId, whereIn: botsId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else
                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      final botdata = doc.data() as Map<String, dynamic>;
                      return Container(
                        decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.black54)),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    BotStatus(doc.reference.id)));
                          },
                          title: Text(botdata["name"],
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                              )),
                          subtitle: Text(botdata["description"],
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black26,
                              )),
                        ),
                      );
                    }).toList(),
                  );
              },
            );
          }
          return Loading();
        },
      ),
    );
  }
}
