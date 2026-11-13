import 'package:flutter/material.dart';
import 'package:litebite/app_theme.dart';
import 'package:litebite/navbar.dart';
import 'package:litebite/splashscrn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lite Bite',
      theme: buildAppTheme(),
      home:  Splashscrn(),
    );
  }
}
 