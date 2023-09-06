import 'package:atalias_game/components/progress_bar.dart';
import 'package:atalias_game/game_manager.dart';
import 'package:atalias_game/screens/game/game_result_score_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class TranslateGameScreen extends StatefulWidget {
  const TranslateGameScreen({super.key});

  @override
  State<TranslateGameScreen> createState() => _TranslateGameScreenState();
}

class _TranslateGameScreenState extends State<TranslateGameScreen> {
  final GameManager gameManager = GetIt.I.get<GameManager>();

  final List<Map<String, dynamic>> questions = [
    {
      "original_phrase": "All my friends are heathens, take it slow",
      "answer_options": [
        "Todos os meus amigos são pagãos, vá devagar",
        "Todos os meus amigos são saudáveis, vá devagar",
        "Todos os meus amigos são estranhos, vá devagar",
        "Todos os meus amigos são artistas, vá devagar"
      ],
      "correct_answer": "Todos os meus amigos são pagãos, vá devagar"
    },
    {
      "original_phrase": "Wait for them to ask you who you know",
      "answer_options": [
        "Espere que eles perguntem quem você conhece",
        "Espere que eles perguntem o que você sabe",
        "Espere que eles perguntem onde você está",
        "Espere que eles perguntem por que você está aqui"
      ],
      "correct_answer": "Espere que eles perguntem quem você conhece"
    },
    {
      "original_phrase": "Please don't make any sudden moves",
      "answer_options": [
        "Por favor, não faça movimentos repentinos",
        "Por favor, faça muitos movimentos",
        "Por favor, evite fazer qualquer movimento",
        "Por favor, dance com movimentos suaves"
      ],
      "correct_answer": "Por favor, não faça movimentos repentinos"
    },
    {
      "original_phrase": "You don't know the half of the abuse",
      "answer_options": [
        "Você não conhece metade do abuso",
        "Você não sabe o que acontece",
        "Você não entende o que significa",
        "Você não tem ideia do que está acontecendo"
      ],
      "correct_answer": "Você não conhece metade do abuso"
    },
    {
      "original_phrase": "Welcome to the room of people",
      "answer_options": [
        "Bem-vindo à sala das pessoas",
        "Bem-vindo à festa das pessoas",
        "Bem-vindo ao clube das pessoas",
        "Bem-vindo à casa das pessoas"
      ],
      "correct_answer": "Bem-vindo à sala das pessoas"
    },
    {
      "original_phrase": "Who have rooms of people that they loved one day",
      "answer_options": [
        "Que têm quartos de pessoas que eles amaram um dia",
        "Que têm amigos que eles amaram um dia",
        "Que têm memórias de pessoas que eles amaram um dia",
        "Que têm histórias de pessoas que eles amaram um dia"
      ],
      "correct_answer": "Que têm quartos de pessoas que eles amaram um dia"
    },
    {
      "original_phrase": "Docked away",
      "answer_options": ["Ancorado longe", "Escondido", "Partiu", "Afundou"],
      "correct_answer": "Ancorado longe"
    },
    {
      "original_phrase": "Just because we check the guns at the door",
      "answer_options": [
        "Só porque verificamos as armas na porta",
        "Só porque escondemos as armas na porta",
        "Só porque levamos as armas conosco",
        "Só porque deixamos as armas na porta"
      ],
      "correct_answer": "Só porque verificamos as armas na porta"
    },
    {
      "original_phrase": "Doesn't mean our brains will change from hand grenades",
      "answer_options": [
        "Não significa que nossos cérebros mudarão de granadas",
        "Não significa que nossas mentes explodirão com granadas",
        "Não significa que nossas cabeças se transformarão em granadas",
        "Não significa que nossa inteligência se tornará granadas"
      ],
      "correct_answer": "Não significa que nossos cérebros mudarão de granadas"
    },
    {
      "original_phrase": "You'll never know the psychopath sitting next to you",
      "answer_options": [
        "Você nunca conhecerá o psicopata sentado ao seu lado",
        "Você nunca entenderá o psicopata sentado ao seu lado",
        "Você nunca verá o psicopata sentado ao seu lado",
        "Você nunca sentirá o psicopata sentado ao seu lado"
      ],
      "correct_answer": "Você nunca conhecerá o psicopata sentado ao seu lado"
    }
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
        context.read<GameManager>().setGameFinished('complete');
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
        automaticallyImplyLeading: false,
        title: const Text('Traduza a frase'),
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
                    child: SingleChildScrollView(
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
                                      height: answer == questions[currentQuestionIndex]['answer_options'][index] ? 90 : 70,
                                      margin: const EdgeInsets.symmetric(vertical: 4),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color:
                                            answer == questions[currentQuestionIndex]['answer_options'][index] ? Colors.deepPurple : Colors.white,
                                        borderRadius: BorderRadius.circular(21),
                                      ),
                                      child: Center(
                                        child: Text(
                                          questions[currentQuestionIndex]['answer_options'][index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: answer == questions[currentQuestionIndex]['answer_options'][index] ? 18 : 14,
                                            color:
                                                answer == questions[currentQuestionIndex]['answer_options'][index] ? Colors.white : Colors.black54,
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
                  ),
                ],
              ),
            ),
    );
  }
}
