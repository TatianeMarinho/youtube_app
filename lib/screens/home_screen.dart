import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/youtube.png', width: 98, height: 22),
        actions: [
          IconButton(
            onPressed: () {
              print('acao: videocam');
            },
            icon: Icon(Icons.videocam),
          ),
          IconButton(
            onPressed: () {
              print('acao: pesquisa');
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              print('acao: conta');
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
