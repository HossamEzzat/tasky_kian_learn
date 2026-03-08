import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:td/screens/main_screen.dart';
import 'package:td/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name") ?? "";

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(name: name), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff181818),
        appBarTheme: AppBarThemeData(
          backgroundColor: Color(0xff181818),
          foregroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: name.isEmpty ? WelcomeScreen() : MainScreen(),
    );
  }
}
