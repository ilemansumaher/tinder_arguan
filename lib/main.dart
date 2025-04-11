
import 'package:flutter/material.dart';
import 'package:lesson1/views/main_page/repository/main_screen.dart';

void main() {
  runApp(const TinderApp());
}

class TinderApp extends StatelessWidget {
  const TinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
