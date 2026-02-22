import 'package:flutter/material.dart';
import 'package:youtube_app/core/theme/app_colors.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  //configura o texto de dica na barra de pesquisa
  @override
  String? get searchFieldLabel => "Pesquisar no Youtube";

  //estiliza a barra para combinar com o tema
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: AppColors.softLime),
      ),
      textTheme: const TextTheme(titleLarge: TextStyle(color: Colors.white)),
    );
  }

  //Botões de ação a direita(limpar texto)
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = ''; //limpa o que foi digitado
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  //botao a esquerda(voltar)
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, ''); //fecha a pesquisando retornando vazio
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // O que aparece quando o usuário confirma a pesquisa
  @override
  Widget buildResults(BuildContext context) {
    //retorna o termo pesquisado para a pagina anterior
    Future.microtask(
      () => close(context, query),
    ); //fecha a tela assim que o resultado for gerado
    return const Center(child: CircularProgressIndicator());
  }

  //o que aparece enquanto o usuario digita
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = ["Músicas 2026", "Notícias", "Playlist"];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestions[index],
            style: const TextStyle(color: Colors.white),
          ),
          leading: const Icon(Icons.history, color: Colors.white),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
