import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:eiga_to_simple/config.dart';
import 'screens/home_screen.dart';

Future<void> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: FirebaseConfig.get('apiKey'),
      authDomain: FirebaseConfig.get('authDomain'),
      projectId: FirebaseConfig.get('projectId'),
      storageBucket: FirebaseConfig.get('storageBucket'),
      messagingSenderId: FirebaseConfig.get('messagingSenderId'),
      appId: FirebaseConfig.get('appId'),
      measurementId: FirebaseConfig.get('measurementId'),
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // アプリ全体のテーマを設定
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Awesome Blog',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black, // タイトル色を黒に設定
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
          ),
          labelSmall: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // タイトル色を白に設定
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
          ),
          labelSmall: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
      themeMode: ThemeMode.system, // システム設定に従う
      home: const HomeScreen(),
    );
  }
}
