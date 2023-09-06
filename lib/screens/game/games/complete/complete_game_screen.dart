import 'package:atalias_game/components/progress_bar.dart';
import 'package:atalias_game/game_manager.dart';
import 'package:atalias_game/screens/game/game_result_score_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CompleteGameScreen extends StatefulWidget {
  const CompleteGameScreen({super.key});

  @override
  State<CompleteGameScreen> createState() => _CompleteGameScreenState();
}

class _CompleteGameScreenState extends State<CompleteGameScreen> {
  final GameManager gameManager = GetIt.I.get<GameManager>();

  final List<Map<String, dynamic>> questions = [
    {
      "incomplete_phrase": "I thought love was only true in _______",
      "answer_options": ["dreams", "songs", "rainbows", "fairytales"],
      "correct_answer": "fairytales"
    },
    {
      "incomplete_phrase": "Meant for someone else but not for _______",
      "answer_options": [
        "you",
        "me",
        "us",
        "them",
      ],
      "correct_answer": "me"
    },
    {
      "incomplete_phrase": "Love was out to get _______",
      "answer_options": [
        "me",
        "happiness",
        "trouble",
        "joy",
      ],
      "correct_answer": "me"
    },
    {
      "incomplete_phrase": "Disappointment haunted all my _______",
      "answer_options": [
        "days",
        "nights",
        "dreams",
        "thoughts",
      ],
      "correct_answer": "dreams"
    },
    {
      "incomplete_phrase": "Then I saw her face, now I'm a _______",
      "answer_options": [
        "dreamer",
        "believer",
        "lover",
        "singer",
      ],
      "correct_answer": "believer"
    },
    {
      "incomplete_phrase": "Not a trace of doubt in my _______",
      "answer_options": [
        "head",
        "heart",
        "mind",
        "soul",
      ],
      "correct_answer": "mind"
    },
    {
      "incomplete_phrase": "I'm in love, I'm a _______",
      "answer_options": [
        "fighter",
        "dreamer",
        "lover",
        "believer",
      ],
      "correct_answer": "believer"
    },
    {
      "incomplete_phrase": "I couldn't leave her if I _______",
      "answer_options": [
        "tried",
        "cried",
        "lied",
        "died",
      ],
      "correct_answer": "tried"
    },
    {
      "incomplete_phrase": "I thought love was more or less a givin' _______",
      "answer_options": [
        "thing",
        "ring",
        "wing",
        "sing",
      ],
      "correct_answer": "thing"
    },
    {
      "incomplete_phrase": "Seems the more I gave the less I _______",
      "answer_options": [
        "wanted",
        "needed",
        "got",
        "sought",
      ],
      "correct_answer": "got"
    },
    {
      "incomplete_phrase": "What's the use in trying? All you get is _______",
      "answer_options": [
        "joy",
        "rain",
        "pain",
        "play",
      ],
      "correct_answer": "pain"
    }
  ];

  int currentQuestionIndex = 0;
  String answer = '';
  int score = 0;

  void nextQuestion(context) {
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
        title: const Text('Complete a Frase'),
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
                        Container(
                          padding: const EdgeInsets.all(32),
                          child: Text(
                            questions[currentQuestionIndex]['incomplete_phrase'],
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
                                    height: answer == questions[currentQuestionIndex]['answer_options'][index] ? 80 : 60,
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
