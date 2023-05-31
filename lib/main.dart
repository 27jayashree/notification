
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'NotificationSevice/NotificationSevice.dart';
import 'NotificationSevice/NotificationApiCall.dart';


/*---------------push notification message start 28-11-2022----------------*/
Future<void> backroundHandler(RemoteMessage message) async {
  print(" This is message from background");
  print(message.notification!.title);
  print(message.notification!.body);
}
/*---------------push notification message end 28-11-2022----------------*/

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBu28QgI5yEpAaiyJHdWh81IkKLPBTfQKg",
            authDomain: "tankhapay.firebaseapp.com",
            projectId: "tankhapay",
            storageBucket: "tankhapay.appspot.com",
            messagingSenderId: "82665791823",
            appId: "1:82665791823:web:d13f983ae0d8d8022aa53a",
            measurementId: "G-GLHXM7PC6M")
    );
    FirebaseMessaging.onBackgroundMessage(backroundHandler);
  }
  else{
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(backroundHandler);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  static final CollectionReference _productss = FirebaseFirestore.instance.collection('products');



  @override
  void initState() {
    super.initState();

    LocalNotificationService.initilize();


    FirebaseMessaging.instance.getToken().then((token) {
      print("token: $token");
      saveTokenToDatabase(token!);
    });

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");

          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }

        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          // LocalNotificationService.display(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }


  saveTokenToDatabase(String token)
  {
    var map = {
      'token':token
    };
    _productss.doc('user').set(map);
    NotificationApiCall().saveNotificationToken(token);
    print("Token Saved SuccessFully");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          ],
        ),
      ),
    );
  }


}
