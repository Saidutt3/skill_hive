import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skill_hive/view/homeScreen/HomePage.dart';
import 'package:skill_hive/view/homeScreen/Widget/splashScreen.dart';
import 'package:skill_hive/view/introScreen.dart';

import 'view/homeScreen/Widget/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB31JdDIyZZhP4xdsedLWfc9mlx7wj9sGc",
          appId: "1:591101585603:android:80aa879055a2419ddb9a76",
          messagingSenderId: "591101585603",
          projectId: "skillhive-e9fa6"));
  runApp(const MainApp());
}

// Define a data model for each service

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
