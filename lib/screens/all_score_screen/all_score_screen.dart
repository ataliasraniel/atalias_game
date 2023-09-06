import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AllScoreScreen extends StatefulWidget {
  const AllScoreScreen({super.key});

  @override
  State<AllScoreScreen> createState() => _AllScoreScreenState();
}

class _AllScoreScreenState extends State<AllScoreScreen> {
  final List<String> teams = ['Neeko', 'Celeste', 'TURBO', 'Zodíaco', 'Piratas'];
  List<int> scores = [100, 200, 300, 400, 500];

  final channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080/score'));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Pontuação geral'),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(62),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text('Pontuação geral',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 32),
              StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    final List<dynamic> dataList = jsonDecode(snapshot.data.toString());
                    dataList.sort((a, b) => b['score'].compareTo(a['score']));
                    return Expanded(
                      child: ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(dataList[index]['team']),
                              subtitle: Text(dataList[index]['score'].toString()),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text('Carregando...');
                  }
                },
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
        ));
  }
}
