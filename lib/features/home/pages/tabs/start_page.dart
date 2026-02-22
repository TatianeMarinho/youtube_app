import 'package:flutter/material.dart';
import 'package:youtube_app/features/home/models/video_model.dart';
import 'package:youtube_app/features/home/services/youtube_service.dart';
import 'package:youtube_app/features/home/widgets/video_card.dart';

class StartPage extends StatefulWidget {
  final String search; // recebe o termo de busca
  const StartPage({super.key, this.search = " "}); //padrao é nada escrito

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late Future<List<VideoModel>> _videosFuture;
  final YoutubeService _service = YoutubeService();

  @override
  void initState() {
    super.initState();
    //inicia com o que vier no widget.search
    _videosFuture = _service.searchVideos(widget.search);
  }

  //metodo que detecta quanto busca muda
  @override
  void didUpdateWidget(covariant StartPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.search != widget.search) {
      setState(() {
        _videosFuture = _service.searchVideos(widget.search);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VideoModel>>(
      future: _videosFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());

          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Center(child: Text("Erro ao carregar vídeos"));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum vídeo encontrado'));
            }

            final videos = snapshot.data!;

            return GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: videos.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200, //largura maxima do card
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.05, //altura fixa real do card
              ),
              itemBuilder: (context, index) {
                return VideoCard(video: videos[index]);
              },
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
