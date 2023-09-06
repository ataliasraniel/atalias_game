import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameManager with ChangeNotifier {
  final channel = WebSocketChannel.connect(Uri.parse('ws://192.168.18.228:8080/teams'));
  final scoreChannel = WebSocketChannel.connect(Uri.parse('ws://192.168.18.228:8080/score'));

  final List<String> teams = ['Neeko', 'Celeste', 'TURBO', 'Zodíaco', 'Piratas'];
  List<String> availableTeams = [];

  int _globalScore = 0;
  String _teamName = '';
  String get teamName => _teamName;
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

  void addScore(int score) {
    _globalScore += score;
    scoreChannel.sink.add(jsonEncode({'team': _teamName, 'score': _globalScore}));
  }

  void setTeamName(String name) {
    _teamName = name;
    notifyListeners();
  }

  void setAvailableTeams(List<String> teams) {
    availableTeams = teams;
    notifyListeners();
  }
}
