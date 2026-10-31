import 'package:flutter/material.dart';
import 'package:football_app/view/home/home_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Tournament',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
