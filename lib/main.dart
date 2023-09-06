import 'package:atalias_game/screens/all_score_screen/all_score_screen.dart';
import 'package:atalias_game/screens/complete/complete_game_screen.dart';
import 'package:atalias_game/screens/game/game_selection/game_selection_screen.dart';
import 'package:atalias_game/screens/game/games/quiz/quiz_screen.dart';
import 'package:atalias_game/screens/game/games/select_frase/select_frase_game.dart';
import 'package:atalias_game/screens/game/games/translate/translate_game_screen.dart';
import 'package:atalias_game/screens/game/home.dart';
import 'package:atalias_game/screens/team_selection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'game_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<GameManager>(GameManager());

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<GameManager>(
      create: (_) => GameManager(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atalia`s game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Home(),
      routes: {
        '/home': (context) => const Home(),
        '/gameselection': (context) => const GameSelectionScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/translate': (context) => const TranslateGameScreen(),
        '/complete': (context) => const CompleteGameScreen(),
        '/select': (context) => const SelectGameScreen(),
        '/score': (context) => const AllScoreScreen(),
        '/teamselection': (context) => const TeamSelection(),
      },
    );
  }
}
