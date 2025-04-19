import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sakn/features/auth/login_screen.dart';
import 'package:sakn/features/error_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  ErrorWidget.builder =
      (FlutterErrorDetails flutterErrorDetails) => ErrorScreen();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sakn',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

// Firebase

// Authentication FirebaseAuth.instance - Firebase Firestore FirebaseFirestore.instance

// CRUD - SQL

// Table - Column & Rows - data

// Nosql

// Collection - documents - fields

// read 50k - write 20k
// Caching - Unlimited
