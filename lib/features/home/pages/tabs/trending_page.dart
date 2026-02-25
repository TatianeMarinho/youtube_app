import 'package:flutter/material.dart';
import 'package:youtube_app/features/home/services/youtube_service.dart';
import 'package:youtube_app/features/home/widgets/video_card.dart';

import '../../models/video_model.dart' show VideoModel;

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  final YoutubeService _service = YoutubeService();
  late Future<List<VideoModel>> _trendingFuture;

  @override //carrega os videos assim que abre a pagina
  void initState() {
    super.initState();
    _trendingFuture = _service.getTrendingVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<VideoModel>>(
        future: _trendingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Erro ao carregar videos em alta",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final videos = snapshot.data ?? [];

          if (videos.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum video em alta no momento",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _trendingFuture = _service.getTrendingVideos();
              });
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 270,
                    child: VideoCard(video: videos[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
