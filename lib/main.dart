import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sakn/features/auth/login_screen.dart';
import 'package:sakn/features/buttom_navigation_bar/buttom_vav_bar.dart';
import 'package:sakn/features/error_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  await EasyLocalization.ensureInitialized();

  ErrorWidget.builder =
      (FlutterErrorDetails flutterErrorDetails) => ErrorScreen();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: LoadingAnimationWidget.progressiveDots(
                  color: Colors.black,
                  size: 60,
                ),
              ),
            ),
          );
        }

        return GetMaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Sakn',
          debugShowCheckedModeBanner: false,
          home: snapshot.data != null ? ButtomVavBar() : LoginScreen(),
        );
      },
    );
  }
}

// Firebase Auth - authStateChanges Stream<User?> //

// StreamBuilder - FutureBuilder
