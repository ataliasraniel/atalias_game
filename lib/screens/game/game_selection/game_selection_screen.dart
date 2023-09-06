import 'package:atalias_game/game_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class GameSelectionScreen extends StatefulWidget {
  const GameSelectionScreen({super.key});

  @override
  State<GameSelectionScreen> createState() => _GameSelectionScreenState();
}

class _GameSelectionScreenState extends State<GameSelectionScreen> {
  final List<Map<String, dynamic>> games = [
    {'id': 0, 'name': 'Music Quiz', 'description': 'Pergunta e resposta sobre a música', 'isAvailable': true, 'route': '/quiz'},
    {'id': 1, 'name': 'Translate the frase', 'description': 'Traduza a frase da música', 'isAvailable': false, 'route': '/translate'},
    {'id': 2, 'name': 'Complete the frase', 'description': 'Ouça a música e complete a frase', 'isAvailable': false, 'route': '/complete'},
    {'id': 3, 'name': 'Select the frase', 'description': 'Ouça a música e selecione a frase correta', 'isAvailable': false, 'route': '/select'}
  ];

  // void checkIfIsAvailable() {
  //   gameManager.finishedGames.forEach((key, value) {
  //     if (value) {
  //       games.firstWhere((element) => element['route'] == '/$key')['isAvailable'] = true;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameManager>(builder: (context, gameManager, child) {
      gameManager.finishedGames.forEach((key, value) {
        if (value) {
          games.firstWhere((element) => element['route'] == '/$key')['isAvailable'] = true;
        }
      });
      return Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   gameManager.setGameFinished('complete');
        // }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              const Text('Selecione o jogo'),
              const Spacer(),
              Text(gameManager.teamName),
            ],
          ),
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
                          trailing: games[index]['isAvailable'] ? const Icon(Icons.chevron_right) : const Icon(Icons.lock),
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
    });
  }
}
