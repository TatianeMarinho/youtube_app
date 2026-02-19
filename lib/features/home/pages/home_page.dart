import 'package:flutter/material.dart';
import 'package:youtube_app/features/home/pages/tabs/library_page.dart';
import 'package:youtube_app/features/home/pages/tabs/registrations_page.dart';
import 'package:youtube_app/features/home/pages/tabs/start_page.dart';
import 'package:youtube_app/features/home/pages/tabs/trending_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    StartPage(),
    TrendingPage(),
    RegistrationsPage(),
    LibraryPage(),
  ];

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

      body: _pages[_currentIndex], // troca a pagina
      //bottomNavigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: 'Em alta'),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Inscrições',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Biblioteca',
          ),
        ],
      ),
    );
  }
}
