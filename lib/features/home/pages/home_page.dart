import 'package:flutter/material.dart';
import 'package:youtube_app/features/home/pages/tabs/library_page.dart';
import 'package:youtube_app/features/home/pages/tabs/registrations_page.dart';
import 'package:youtube_app/features/home/pages/tabs/start_page.dart';
import 'package:youtube_app/features/home/pages/tabs/trending_page.dart';
import 'package:youtube_app/features/home/widgets/custom_search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _searchedTerm = ' '; // variavel de controle

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      StartPage(search: _searchedTerm), //passa o termo pesquisado
      TrendingPage(),
      RegistrationsPage(),
      LibraryPage(),
    ];

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
            onPressed: () async {
              // abre a tela de busca e aguarda o resultado
              String? res = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
              //se digitou algo, atualiza o estado
              if (res != null && res.isNotEmpty) {
                setState(() {
                  _searchedTerm = res;
                  _currentIndex =
                      0; //volta para a aba Inicio caso a pesquisa tenha sido feita em outra aba
                });
              }
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
