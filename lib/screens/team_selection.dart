import 'dart:convert';

import 'package:atalias_game/game_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TeamSelection extends StatefulWidget {
  const TeamSelection({super.key});

  @override
  State<TeamSelection> createState() => _TeamSelectionState();
}

class _TeamSelectionState extends State<TeamSelection> {
  final GameManager gameManager = GetIt.I.get<GameManager>();
  final channel = WebSocketChannel.connect(Uri.parse('ws://192.168.18.228:8080/teams'));
  final scoreChannel = WebSocketChannel.connect(Uri.parse('ws://192.168.18.228:8080/score'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nome do time'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Defina o nome do time',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              )),
          // ElevatedButton(
          //     onPressed: () {
          //       gameManager.setTeamName('asdasd');
          //     },
          //     child: Text('asda'))
          StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<dynamic> dataList = jsonDecode(snapshot.data.toString());
                  final List<String> allTeams = gameManager.teams;
                  for (final team in dataList) {
                    if (allTeams.contains(team['team'])) {
                      allTeams.remove(team['team']);
                    }
                  }
                  return ListView.builder(
                    itemCount: allTeams.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        title: Text(allTeams[index]),
                        value: allTeams[index],
                        groupValue: gameManager.teamName,
                        onChanged: (value) {
                          setState(() {
                            gameManager.setTeamName(value!);
                          });
                        },
                      );
                    },
                  );
                } else {
                  return const Text('Carregando...');
                }
              }),
          ElevatedButton(
              onPressed: () {
                scoreChannel.sink.add(jsonEncode({'team': gameManager.teamName, 'score': 0}));
                Navigator.pushNamed(context, '/gameselection');
              },
              child: const Text('Selecionar'))
        ],
      ),
    );
  }
}
