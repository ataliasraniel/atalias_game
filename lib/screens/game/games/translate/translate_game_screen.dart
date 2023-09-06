import 'package:atalias_game/components/progress_bar.dart';
import 'package:atalias_game/game_manager.dart';
import 'package:atalias_game/screens/game/game_result_score_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TranslateGameScreen extends StatefulWidget {
  const TranslateGameScreen({super.key});

  @override
  State<TranslateGameScreen> createState() => _TranslateGameScreenState();
}

class _TranslateGameScreenState extends State<TranslateGameScreen> {
  final GameManager gameManager = GetIt.I.get<GameManager>();

  final List<Map<String, dynamic>> questions = [
    {
      "original_phrase": "But there's one sound That no one knows What does the fox say?",
      "answer_options": [
        "Mas há um som que todos conhecem. O que a raposa diz?",
        "Mas há um som que ninguém conhece. O que a raposa diz?",
        "Mas há um som que todos ouvem. O que a raposa diz?",
        "Mas há um som que todos esquecem. O que a raposa diz?"
      ],
      "correct_answer": "Mas há um som que ninguém conhece. O que a raposa diz?"
    },
    {
      "original_phrase": "What the fox say?",
      "answer_options": ["O que a raposa canta?", "O que a raposa diz?", "O que a raposa pula?", "O que a raposa dança?"],
      "correct_answer": "O que a raposa diz?"
    },
    {
      "original_phrase": "The secret of the fox Ancient mystery Somewhere deep in the woods I know you're hiding",
      "answer_options": [
        "O segredo da raposa Mistério antigo Algum lugar profundo na floresta Eu sei que você está voando",
        "O segredo da raposa Mistério antigo Algum lugar profundo no oceano Eu sei que você está nadando",
        "O segredo da raposa Mistério antigo Algum lugar profundo no deserto Eu sei que você está correndo",
        "O segredo da raposa Mistério antigo Algum lugar profundo na cidade Eu sei que você está voando"
      ],
      "correct_answer": "O segredo da raposa Mistério antigo Algum lugar profundo na floresta Eu sei que você está voando"
    }
  ];

  int currentQuestionIndex = 0;
  String answer = '';
  int score = 0;

  void nextQuestion() {
    checkAnswer();
    setState(() {
      currentQuestionIndex++;
    });
    checkIfQuizIsOver();
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      answer = '';
    });
  }

  void selectAnswer(String value) {
    setState(() {
      answer = value;
    });
    print(answer);
  }

  void checkAnswer() {
    if (answer == questions[currentQuestionIndex]['correct_answer']) {
      score++;
    }
    print('score is $score');
  }

  void checkIfQuizIsOver() {
    if (currentQuestionIndex == questions.length) {
      gameManager.setGameFinished('complete');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return GameResultScoreScreen(score: score);
      }));
    }
    return;
  }

  double? _containerHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traduza a frase'),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              nextQuestion();
            },
            child: const Text('Próxima pergunta'),
          ),
        ),
      ],
      body: currentQuestionIndex == questions.length
          ? const Center(
              child: Text('Fim do jogo'),
            )
          : Padding(
              padding: const EdgeInsets.all(62),
              child: Column(
                children: <Widget>[
                  ProgressBar(currentQuestionIndex: currentQuestionIndex, length: questions.length),
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(32),
                          child: Text(
                            questions[currentQuestionIndex]['original_phrase'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...List.generate(
                            questions[currentQuestionIndex]['answer_options'].length,
                            (index) => InkWell(
                                  onTap: () {
                                    selectAnswer(questions[currentQuestionIndex]['answer_options'][index]);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: double.maxFinite,
                                    height: answer == questions[currentQuestionIndex]['answer_options'][index] ? 120 : 80,
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: answer == questions[currentQuestionIndex]['answer_options'][index] ? Colors.deepPurple : Colors.white,
                                      borderRadius: BorderRadius.circular(21),
                                    ),
                                    child: Center(
                                      child: Text(
                                        questions[currentQuestionIndex]['answer_options'][index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: answer == questions[currentQuestionIndex]['answer_options'][index] ? 18 : 14,
                                          color: answer == questions[currentQuestionIndex]['answer_options'][index] ? Colors.white : Colors.black54,
                                          fontWeight: answer == questions[currentQuestionIndex]['answer_options'][index]
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
