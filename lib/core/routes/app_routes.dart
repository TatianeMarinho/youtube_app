import 'package:go_router/go_router.dart';
import 'package:youtube_app/features/home/pages/home_page.dart';
import 'package:youtube_app/features/home/pages/video_player_page.dart';
import '../../features/home/models/video_model.dart' show VideoModel;

class AppRoutes {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/player',
        builder: (context, state) {
          final video = state.extra as VideoModel;
          return VideoPlayerPage(video: video);
        },
      ),
    ],
  );
}
