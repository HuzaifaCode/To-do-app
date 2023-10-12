import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:todo/todo_screen.dart';

import 'database.dart';
import 'firebase_options.dart';
import 'tasks.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp( MyApp()
  );
}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  final dbHelper = DatabaseHelper();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    dbHelper.initializeDatabase(); // Initialize the database in the constructor

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To-Do App",
      home: TaskList(
        dbHelper:dbHelper ,
      ),
    );
  }
}
