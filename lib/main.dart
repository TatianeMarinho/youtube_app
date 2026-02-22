import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_colors.dart';
import 'features/home/services/youtube_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");

  await YoutubeService().searchVideos("flutter");

  runApp(const MyStreamApp());
}

class MyStreamApp extends StatelessWidget {
  const MyStreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    //conectando as rotas
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Stream Youtube',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.deepWine,
        primaryColor: AppColors.fireRed,
        //appBarTheme
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.burnRed,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.softLime),
        ),
        //bottomNavigatorTheme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.burnRed,
          selectedItemColor: AppColors.electricGreen,
          unselectedItemColor: AppColors.softLime,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
      ),
      routerConfig: AppRoutes.router,
    );
  }
}
