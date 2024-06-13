import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weatherapp/screens/splash_screen.dart';

import 'screens/onboarding_screen.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIns') ?? false;

  runApp(MyApp(isLoggedIns: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIns;

  const MyApp({required this.isLoggedIns, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF218CB5),
        ),
        useMaterial3: true,
      ),
      home: isLoggedIns ? const HomePage() : const SplashScreen(),
      //home: SplashScreen(),

    );
  }
}
