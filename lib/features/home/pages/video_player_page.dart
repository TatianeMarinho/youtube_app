import 'package:flutter/material.dart';
import 'package:youtube_app/core/theme/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/video_model.dart' show VideoModel;

class VideoPlayerPage extends StatefulWidget {
  final VideoModel video;

  const VideoPlayerPage({super.key, required this.video});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    //inicia o player com o ID do video que veio do card
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    //descarta o controller para liberar memoria
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //player de video
            Stack(
              children: [
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: AppColors.fireRed,
                  onReady: () => debugPrint('Player Pronto'),
                ),

                //botao de voltar flutuante
                Positioned(
                  top: 10,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            //detalhes do video
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.softLime,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  //canal
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.fireRed,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.video.channelTitle,
                              style: const TextStyle(
                                color: AppColors.softLime,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            //inscritos
                            const Text(
                              '1.2M inscritos', //placeholder
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      //botao inscrever
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'INSCREVER-SE',
                          style: TextStyle(
                            color: AppColors.fireRed,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Divider(color: Colors.white24, height: 32),

                  //botoes de açao
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(Icons.thumb_up_alt_outlined, "12k"),
                      _buildActionButton(
                        Icons.thumb_down_alt_outlined,
                        "Dislike",
                      ),
                      _buildActionButton(Icons.share, "Compartilhar"),
                      _buildActionButton(Icons.download, "Download"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  //descriçao
                  const Text(
                    'Descrição',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.video.description, //descriçao da api
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.electricGreen, size: 24),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );
  }
}
