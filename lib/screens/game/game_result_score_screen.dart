import 'package:flutter/material.dart';

class GameResultScoreScreen extends StatefulWidget {
  const GameResultScoreScreen({super.key, required this.score});
  final int score;

  @override
  State<GameResultScoreScreen> createState() => _GameResultScoreScreenState();
}

class _GameResultScoreScreenState extends State<GameResultScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(62),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('Resultado do jogo',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 32),
            Text.rich(
              TextSpan(
                text: 'Você acertou ',
                style: const TextStyle(
                  fontSize: 24,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${widget.score} pergunta(s)',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 32),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
