import 'package:atalias_game/screens/all_score_screen/all_score_screen.dart';
import 'package:atalias_game/screens/game/game_selection/game_selection_screen.dart';
import 'package:atalias_game/screens/game/games/quiz/quiz_screen.dart';
import 'package:atalias_game/screens/game/games/translate/translate_game_screen.dart';
import 'package:atalias_game/screens/game/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atalia`s game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
      routes: {
        '/home': (context) => const Home(),
        '/gameselection': (context) => const GameSelectionScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/translate': (context) => const TranslateGameScreen(),
        '/complete': (context) => const TranslateGameScreen(),
        '/select': (context) => const TranslateGameScreen(),
        '/score': (context) => const AllScoreScreen(),
      },
    );
  }
}
