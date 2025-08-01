import 'package:flutter/material.dart';
import 'package:mhack/leaderboard.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Flutter Web',
      debugShowCheckedModeBanner: false,
      home: LeaderboardPage(),
    );
  }
}

