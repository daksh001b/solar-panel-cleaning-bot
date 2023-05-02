import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_panel_cleaning_bot/Pages/bot_status.dart';
import 'package:solar_panel_cleaning_bot/models/bot.dart';

class BotListFiller extends StatefulWidget {
  const BotListFiller({Key? key}) : super(key: key);

  @override
  _BotListFillerState createState() => _BotListFillerState();
}

class _BotListFillerState extends State<BotListFiller> {
  @override
  Widget build(BuildContext context) {
    final botList = Provider.of<List<Bot>>(context);

    print("botlist->>>>>>>>>>>>>>");
    print(botList);
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      itemCount: botList == null ? 0 : botList.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black54)),
          ),
          child: ListTile(
              onTap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => BotStatus(botList[index].botId)));
              },
              title: Text(botList[index].name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  )),
              subtitle: Text(botList[index].description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black26,
                  )),
          ),
        );
      },
    );
  }
}
