import 'package:flutter/material.dart';

class Login extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: null,
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Image.asset('assets/solar_panel.png'),
          SizedBox(height: 20),

        ]
        )
      )
    );
  }
}