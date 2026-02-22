import 'dart:convert';
import 'package:flutter/foundation.dart'; // Import necessário para o debugPrint
import 'package:http/http.dart' as http;
import 'package:youtube_app/core/config/api_config.dart';
import 'package:youtube_app/features/home/models/video_model.dart';

// ponte entre o app e a api
class YoutubeService {
  //metodo de busca
  Future<List<VideoModel>> searchVideos(String query) async {
    try {
      final url = Uri.parse(
        "${ApiConfig.baseUrl}/search"
        "?part=snippet"
        "&type=video"
        "&maxResults=30"
        "&regionCode=BR"
        "&relevanceLanguage=pt"
        "&key=${ApiConfig.youtubeApiKey}"
        "&q=$query",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List items = data['items'];
        return items.map((video) => VideoModel.fromJson(video)).toList();
      }
      return [];
    } catch (e) {
      debugPrint("Erro na busca: $e");
      return [];
    }
  }

  // metodo de trending
  Future<List<VideoModel>> getTrendingVideos() async {
    try {
      final url = Uri.parse(
        "${ApiConfig.baseUrl}/videos"
        "?part=snippet"
        "&chart=mostPopular"
        "&regionCode=BR"
        "&maxResults=30"
        "&key=${ApiConfig.youtubeApiKey}",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List items = data['items'];
        return items.map((video) => VideoModel.fromJson(video)).toList();
      }
      return [];
    } catch (e) {
      debugPrint("Erro no trending: $e");
      return [];
    }
  }
}
