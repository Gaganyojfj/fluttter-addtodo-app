import 'package:billionaireapp/mainScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyAapp());
}

class MyAapp extends StatefulWidget {
  const MyAapp({super.key});

  @override
  State<MyAapp> createState() => _MyAppState();
}

class _MyAppState extends State<MyAapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),

      home: Mainscreen(),
    );
  }
}
