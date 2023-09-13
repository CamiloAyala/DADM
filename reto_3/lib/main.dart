import 'package:flutter/material.dart';
import 'package:reto_3/views/tic_tac_toe_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark
        ),
        useMaterial3: true,
      ),
      home: const TicTacToeView(title: 'Reto 3'),
    );
  }
}