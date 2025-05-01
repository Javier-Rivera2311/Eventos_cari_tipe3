import 'package:flutter/material.dart';
import 'package:my_app/screens/navigate.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title:'Material App',
    debugShowCheckedModeBanner: false,
    home: HomePage()
    );
  }
}