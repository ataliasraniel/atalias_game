import 'package:atalias_game/components/progress_bar.dart';
import 'package:atalias_game/game_manager.dart';
import 'package:atalias_game/screens/game/game_result_score_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final GameManager gameManager = GetIt.I.get<GameManager>();
  int score = 0;

  final List<Map<String, dynamic>> quiz = [
    {
      "question": "Qual é o sentimento predominante do narrador na música?",
      "answers": ["Happiness", "Loneliness", "Anger", "Confusion"],
      "correct_answer": "Loneliness"
    },
    {
      "question": "O narrador da música deseja encontrar algo. O que é?",
      "answers": ["A delicious pizza", "A cute dog", "A friend to hang out with", "A lover to hold"],
      "correct_answer": "A lover to hold"
    },
    {
      "question": "Qual é a atitude do narrador em relação ao amor?",
      "answers": ["She fully believes in love.", "She is skeptical about love.", "She is afraid to fall in love.", "She is eager to find love."],
      "correct_answer": "She is skeptical about love."
    },
    {
      "question": "O que o narrador fez em relação a Cupido?",
      "answers": ["She gave him a second chance.", "She completely ignored him.", "She insulted him.", "She asked for his help."],
      "correct_answer": "She gave him a second chance."
    },
    {
      "question": "Como o narrador se sente em relação à segunda chance dada a Cupido?",
      "answers": [
        "She feels happy and fulfilled.",
        "She feels foolish and stupid.",
        "She feels proud of her decision.",
        "She feels anxious for the next opportunity."
      ],
      "correct_answer": "She feels foolish and stupid."
    }
  ];
  int currentQuestionIndex = 0;
  String answer = '';
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
    });
  }

  void selectAnswer(String value) {
    setState(() {
      answer = value;
    });
    print(answer);
  }

  void checkAnswer() {
    if (answer == quiz[currentQuestionIndex]['correct_answer']) {
      score++;
    }
    print('score is $score');
  }

  void checkIfQuizIsOver() {
    if (currentQuestionIndex == quiz.length) {
      gameManager.setGameFinished('translate');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return GameResultScoreScreen(score: score);
      }));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
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
      body: currentQuestionIndex == quiz.length
          ? const Center(
              child: Text('Fim do jogo'),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 62),
              child: Column(
                children: <Widget>[
                  //a bar to show the progress of the quiz
                  ProgressBar(currentQuestionIndex: currentQuestionIndex, length: quiz.length),
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(32),
                          child: Text(
                            quiz[currentQuestionIndex]['question'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...List.generate(
                          quiz[currentQuestionIndex]['answers'].length,
                          (index) => RadioListTile(
                            title: Text(quiz[currentQuestionIndex]['answers'][index]),
                            value: quiz[currentQuestionIndex]['answers'][index],
                            groupValue: answer,
                            onChanged: (value) {
                              selectAnswer(value.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
