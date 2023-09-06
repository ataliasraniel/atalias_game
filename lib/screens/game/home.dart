import 'package:atalias_game/game_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    GetIt.I.registerSingleton<GameManager>(GameManager());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      'Atalia`s game',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/gameselection');
                      },
                      child: const Text('Começar'),
                    ),
                    const SizedBox(height: 16),
                    TextButton(onPressed: () {}, child: const Text('Créditos'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
