import 'package:atalias_game/game_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GameSelectionScreen extends StatefulWidget {
  const GameSelectionScreen({super.key});

  @override
  State<GameSelectionScreen> createState() => _GameSelectionScreenState();
}

class _GameSelectionScreenState extends State<GameSelectionScreen> {
  final GameManager gameManager = GetIt.I.get<GameManager>();
  @override
  void initState() {
    gameManager.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  final List<Map<String, dynamic>> games = [
    {'id': 0, 'name': 'Music Quiz', 'description': 'Pergunta e resposta sobre a música', 'isAvailable': true, 'route': '/quiz'},
    {'id': 1, 'name': 'Translate the frase', 'description': 'Traduza a frase da música', 'isAvailable': false, 'route': '/translate'},
    {'id': 2, 'name': 'Complete the frase', 'description': 'Ouça a música e complete a frase', 'isAvailable': false, 'route': '/complete'},
    {'id': 3, 'name': 'Select the frase', 'description': 'Ouça a música e selecione a frase correta', 'isAvailable': false, 'route': '/select'}
  ];

  void checkIfIsAvailable() {
    gameManager.finishedGames.forEach((key, value) {
      if (value) {
        games.firstWhere((element) => element['route'] == '/$key')['isAvailable'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkIfIsAvailable();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/score',
          );
        },
        child: const Icon(Icons.score),
      ),
      appBar: AppBar(
        title: const Text('Selecione o jogo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(62),
        child: Column(
          children: <Widget>[
            Card(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  games.length,
                  (index) => ListTile(
                        title: Text(games[index]['name']),
                        subtitle: Text(games[index]['description']),
                        trailing: games[index]['isAvailable'] ? const Icon(Icons.check) : const Icon(Icons.lock),
                        selected: games[index]['isAvailable'],
                        onTap: () {
                          if (games[index]['isAvailable']) {
                            Navigator.pushNamed(
                              context,
                              games[index]['route'],
                            );
                          }
                        },
                      )),
            ))
          ],
        ),
      ),
    );
  }
}
