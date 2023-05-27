import 'package:flutter/material.dart';
import 'package:scholarly/screens/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scholarly',

      theme: ThemeData(fontFamily: 'Poppins', ),
      home: const HomePage(),
    );
  }
}
