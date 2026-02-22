import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_app/core/config/api_config.dart';
import 'package:youtube_app/features/home/models/video_model.dart';

//ponte entre o app e a api
class YoutubeService {
  Future<List<VideoModel>> searchVideos(String query) async {
    //retorna uma lista de objetos
    final url = Uri.parse(
      //construçao da url que sera passada para a requisiçao
      "${ApiConfig.baseUrl}/search"
      "?part=snippet"
      "&type=video"
      "&maxResults=20"
      "&key=${ApiConfig.youtubeApiKey}"
      "&q=$query", //palavra buscada
    );

    final response = await http.get(url); //requisiçao a api

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); //transforma json em map
      final List items = data['items']; //pega so a lista de videos

      //retorna a lista final de objetos
      return items.map((video) => VideoModel.fromJson(video)).toList();
    } else {
      throw Exception("Erro ao buscar videos");
    }
  }
}
