import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/router.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive/hive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('empty');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primary,
        useMaterial3: false,
        iconTheme: const IconThemeData(color: primary),
        scaffoldBackgroundColor: const Color(0xffF7F7F7),
        appBarTheme: const AppBarTheme(foregroundColor: black),
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: primary,
            ),
      ),
      initialRoute: AppPages.splash,
      getPages: appRouter,
    );
  }
}
