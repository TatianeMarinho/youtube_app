import 'package:flutter/material.dart';
import 'package:youtube_app/core/theme/app_colors.dart';
import 'package:youtube_app/features/home/models/video_model.dart';

class VideoCard extends StatelessWidget {
  final VideoModel video;

  const VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.deepWine,
      elevation: 12,
      shadowColor: AppColors.fireRed.withAlpha(60), //sombra
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.white10, width: 0.5), //borda do card
      ),
      clipBehavior:
          Clip.antiAlias, //garante que a imagem respeite as bordas arredondadas
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //imagem
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                Image.network(
                  video.thumbnail,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                //pequena borda ou indicador no topo com o vermelho fogo
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(height: 2, color: AppColors.fireRed),
                ),
              ],
            ),
          ),

          //Titulo
          Expanded(
            // faz o texto ocupar o que sobra sem empurrar
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: Text(
                video.title,
                maxLines: 2, //limita o titulo a duas linhas
                overflow: TextOverflow.ellipsis, //coloca ... se for maior
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.softLime,
                ),
              ),
            ),
          ),

          //titulo canal
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
            child: Text(
              video.channelTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.electricGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
