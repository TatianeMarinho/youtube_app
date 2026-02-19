import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static const String baseUrl = "https://www.googleapis.com/youtube/v3";

  static String get youtubeApiKey => dotenv.env['YOUTUBE_API_KEY'] ?? '';
}
