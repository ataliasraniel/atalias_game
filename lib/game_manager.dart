import 'package:flutter/material.dart';

class GameManager with ChangeNotifier {
  int _globalScore = 0;
  int get globalScore => _globalScore;
  final Map<String, dynamic> _finishedGames = {
    'quiz': false,
    'translate': false,
    'complete': false,
    'select': false,
  };

//getter
  Map<String, dynamic> get finishedGames => _finishedGames;
  void setGameFinished(String game) {
    finishedGames[game] = true;
    notifyListeners();
  }
}
