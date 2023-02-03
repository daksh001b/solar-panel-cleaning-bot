import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CleanOperation{

  static Future<bool> cleanNow() async{
    try {
      DatabaseReference botDataRef = FirebaseDatabase.instance.ref().child('bot1/');
      await botDataRef.update({'needsCleaning': true});
      return true;

    }catch(e){
      print("You got an error: $e");
      return false;
    }
  }

}

