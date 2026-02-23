import 'package:flutter/material.dart';
import 'package:youtube_app/core/theme/app_colors.dart';
import 'package:youtube_app/features/home/models/video_model.dart';
import 'package:youtube_app/features/home/services/youtube_service.dart';
import 'package:youtube_app/features/home/widgets/video_card.dart';

class RegistrationsPage extends StatefulWidget {
  const RegistrationsPage({super.key});

  @override
  State<RegistrationsPage> createState() => _RegistrationsPageState();
}

class _RegistrationsPageState extends State<RegistrationsPage> {
  final YoutubeService _service = YoutubeService();
  late Future<List<VideoModel>> _videosFuture;

  @override
  void initState() {
    super.initState();
    // Para simular o feed de inscrições, vamos buscar vídeos de um tema específico
    _videosFuture = _service.searchVideos("tecnologia");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 1. LISTA HORIZONTAL DE CANAIS (Círculos no topo)
          Container(
            height: 130,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white10, width: 0.5),
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10, // Simulação de 10 canais inscritos
              itemBuilder: (context, index) {
                return _buildChannelAvatar(index);
              },
            ),
          ),

          // 2. FEED DE VÍDEOS DAS INSCRIÇÕES
          Expanded(
            child: FutureBuilder<List<VideoModel>>(
              future: _videosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final videos = snapshot.data ?? [];

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                        left: 15,
                        right: 15,
                      ),
                      child: SizedBox(
                        height: 280,
                        child: VideoCard(video: videos[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget para criar cada círculo de canal no topo
  Widget _buildChannelAvatar(int index) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white10,
                backgroundImage: NetworkImage(
                  "https://picsum.photos/100/100?random",
                ),
              ),
              // Ponto azul indicando vídeo novo (detalhe de UX do YouTube)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.softLime,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            "Canal",
            style: TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
