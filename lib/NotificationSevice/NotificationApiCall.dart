

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;


class NotificationApiCall {

  saveNotificationToken(String token) async
  {



    try {
      final response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "key= AAAAB6Au96s:APA91bGS1ngsHN4eG5r08guzdAqBtN-1haYoCy2ulrFPzab4VRNnvymJviu7hkQGZva93HRx48CnlnxL4RDwxghgyIoaAGifXUad2q3MQolGZ4hQ4aWy90RrU2hGKbZemjU6guxLWbYQ"
        },

        body: jsonEncode(
            {
          "to": token,
          "notification": {
            "title": "First massage",
            "body": "Notification Body",
            "mutable_content": true,
            "sound": "Tri-tone"
          },
        }
        ));


      print(response.statusCode);
      // //print('response.statusCode');

      if (response.statusCode == 200) {
        print("Response");
        print(response.body);
        // //print("success");
      }
      else {

        print("failure");
        throw Exception('Failed to create get product.');
      }
    }
    catch (e) {
      print("Catch Error $e");
    }
  }

}