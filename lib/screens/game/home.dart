import 'package:atalias_game/game_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameManager>(builder: (context, controller, child) {
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(62),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'The Music Guesser',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          if (controller.teamName.isEmpty) {
                            //show a dialog to set team name
                            Navigator.pushNamed(context, '/teamselection');
                          } else {
                            Navigator.pushNamed(context, '/gameselection');
                          }
                        },
                        child: const Text('Começar'),
                      ),
                      const SizedBox(height: 16),
                      // TextButton(
                      //     onPressed: () {
                      //       Navigator.pushNamed(context, '/score');
                      //     },
                      //     child: const Text('Pontos'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
