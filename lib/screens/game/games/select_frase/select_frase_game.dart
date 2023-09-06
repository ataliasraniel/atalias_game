import 'package:atalias_game/components/progress_bar.dart';
import 'package:atalias_game/game_manager.dart';
import 'package:atalias_game/screens/game/game_result_score_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class SelectGameScreen extends StatefulWidget {
  const SelectGameScreen({super.key});

  @override
  State<SelectGameScreen> createState() => _SelectGameScreenState();
}

class _SelectGameScreenState extends State<SelectGameScreen> {
  final GameManager gameManager = GetIt.I.get<GameManager>();

  final List<Map<String, dynamic>> questions = [
    {
      "original_phrase": "And the elephant goes 'toot'",
      "answer_options": [
        "And the elephant says 'toot'",
        "And the elephant says 'squeek'",
        "And the elephant says 'meow'",
        "And the elephant says 'moo'"
      ],
      "correct_answer": "And the elephant goes 'toot'"
    },
    {
      "original_phrase": "Bu there's one sound That no one knows",
      "answer_options": [
        "Bu there's one sound That no one knows",
        "Bu there's one sound That no one hears",
        "Bu there's one sound That no one sees",
        "Bu there's one sound That no one feels"
      ],
    },
    {
      "original_phrase": "What does the fox say?",
      "answer_options": [
        "What do the fox say?",
        "What does the cat say?",
        "What does the fox says?",
        "What does the fox say?",
      ],
      "correct_answer": "What does the fox say?"
    },
    {
      "original_phrase": "The secret of the fox Ancient mystery",
      "answer_options": [
        "The secret of the fox Ancient mystery",
        "The mystery of the tiger Ancient revelation",
        "The enigma of the owl Ancient mystery",
        "The secret of the snake Mysterious history"
      ],
      "correct_answer": "The secret of the fox Ancient mystery"
    },
    {
      "original_phrase": "Somewhere deep in the woods I know you're hiding",
      "answer_options": [
        "Somewhere deep in the ocean I know you're swimming",
        "Somewhere high in the sky I know you're flying",
        "Somewhere deep in the desert I know you're hiding",
        "Somewhere deep in the woods I know you're hiding"
      ],
      "correct_answer": "Somewhere deep in the woods I know you're hiding"
    },
    {
      "original_phrase": "What is your sound? Will we ever know?",
      "answer_options": [
        "What is your secret? Will we ever learn?",
        "What is your favorite food? Will we ever find out?",
        "What is your color? Will we ever discover?",
        "What is your sound? Will we ever know?"
      ],
      "correct_answer": "What is your sound? Will we ever know?"
    },
    {
      "original_phrase": "You're my guardian angel Hiding in the woods",
      "answer_options": [
        "You're my secret agent Hiding in the city",
        "You're my guiding star Hiding in the ocean",
        "You're my shining light Hiding in the sky",
        "You're my guardian angel Hiding in the woods"
      ],
      "correct_answer": "You're my guardian angel Hiding in the woods"
    },
  ];

  int currentQuestionIndex = 0;
  String answer = '';
  int score = 0;

  void nextQuestion(BuildContext context) {
    checkAnswer();
    setState(() {
      currentQuestionIndex++;
    });
    checkIfQuizIsOver(context);
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

  void checkIfQuizIsOver(BuildContext context) {
    if (currentQuestionIndex == questions.length) {
      setState(() {
        context.read<GameManager>().setGameFinished('select');
      });
      Navigator.pushReplacementNamed(context, '/score');
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione a frase'),
        automaticallyImplyLeading: false,
      ),
      persistentFooterButtons: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              nextQuestion(context);
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
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                children: <Widget>[
                  ProgressBar(currentQuestionIndex: currentQuestionIndex, length: questions.length),
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   padding: const EdgeInsets.all(32),
                        //   child: Text(
                        //     questions[currentQuestionIndex]['incomplete_phrase'],
                        //     style: const TextStyle(
                        //       fontSize: 24,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
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
