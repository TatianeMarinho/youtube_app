import 'package:flutter/material.dart';
import 'package:youtube_app/core/theme/app_colors.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SEÇÃO HISTÓRICO
            _buildSectionHeader(Icons.history, "Histórico", "Ver tudo"),
            SizedBox(
              height: 150, // para que o listviewsaiba o tamanho
              child: ListView.builder(
                scrollDirection:
                    Axis.horizontal, //faz o scrooll ser para os lados
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 5, // Simulação de 5 vídeos recentes
                itemBuilder: (context, index) {
                  return _buildRecentVideoItem(); //desenha cada quadrado
                },
              ),
            ),

            const Divider(color: Colors.white10, height: 40),

            // OPÇÕES DA BIBLIOTECA (Lista vertical de ações)
            _buildLibraryOption(Icons.video_library_outlined, "Seus vídeos"),
            _buildLibraryOption(
              Icons.download_for_offline_outlined,
              "Downloads",
              subtitle: "20 vídeos",
            ),

            _buildLibraryOption(Icons.local_movies_outlined, "Seus filmes"),
            _buildLibraryOption(
              Icons.watch_later_outlined,
              "Assistir mais tarde",
              subtitle: "Vídeos que você salvou",
            ),

            const Divider(color: Colors.white10, height: 40),

            // SEÇÃO PLAYLISTS
            _buildSectionHeader(null, "Playlists", "A-Z"),
            _buildLibraryOption(
              Icons.add,
              "Nova playlist",
              iconColor: AppColors.electricGreen,
            ),
            _buildLibraryOption(
              Icons.thumb_up_alt_outlined,
              "Vídeos marcados com 'Gostei'",
              subtitle: "450 vídeos",
            ),
          ],
        ),
      ),
    );
  }

  // Widget para o cabeçalho das seções (ex: Histórico)
  //cria linha que tem o titulo
  Widget _buildSectionHeader(IconData? icon, String title, String actionText) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          if (icon != null)
            Icon(icon, color: AppColors.electricGreen, size: 28),
          if (icon != null) const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            actionText,
            style: const TextStyle(
              color: AppColors.electricGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget para cada item da lista (Seus vídeos, Downloads, etc)
  Widget _buildLibraryOption(
    IconData icon,
    String title, {
    String? subtitle,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.electricGreen),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(color: AppColors.softLime, fontSize: 12),
            )
          : null,
      onTap: () {},
    );
  }

  // Widget que simula um vídeo no histórico (Miniatura + Título)
  Widget _buildRecentVideoItem() {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://picsum.photos/200/110",
                  ), // Imagem aleatória
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Título do Vídeo Assistido Recentemente",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          const Text(
            "Nome do Canal",
            style: TextStyle(color: AppColors.softLime, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
