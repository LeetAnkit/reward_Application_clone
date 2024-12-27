import 'package:dashboard_template/pages/contact.dart';
import 'package:dashboard_template/pages/home.dart';
import 'package:dashboard_template/pages/settings.dart';
import 'package:dashboard_template/pages/sign_up_screen.dart';
import 'package:dashboard_template/pages/sign_up_screen.dart'; // Ensure consistent import
import 'package:dashboard_template/pages/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

ThemeData createTheme([Brightness? brightness]) {
  return ThemeData(
    brightness: brightness,
    fontFamily: "Quicksand",
    primarySwatch: Colors.indigo,
    hintColor: Colors.deepOrangeAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: createTheme(),
      darkTheme: createTheme(Brightness.dark),
      initialRoute: '/sign_up_screen', // Setting initial route
      routes: {
        '/sign_up_screen': (context) => SignUpScreen(), // Default route
        '/home': (context) => HomePage(),
        '/transaction': (context) => TransactionPage(),
        '/settings': (context) => SettingsPage(),
        '/contact': (context) => ContactPage(),
      },
    );
  }
}
