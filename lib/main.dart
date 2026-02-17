import 'package:flutter/material.dart';
import 'package:youtube_app/routes/app_routes.dart';
import 'package:youtube_app/theme/app_colors.dart';

void main() => runApp(const MyStreamApp());

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
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.burnRed,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.softLime),
        ),
        iconTheme: const IconThemeData(color: AppColors.softLime),
      ),
      routerConfig: AppRoutes.router,
    );
  }
}
