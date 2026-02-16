import 'package:flutter/material.dart';
import 'package:youtube_app/routes/app_routes.dart';

void main() => runApp(const MyStreamApp());

class MyStreamApp extends StatelessWidget {
  const MyStreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    //conectando as rotas
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Stream Youtube',
      routerConfig: AppRoutes.router,
    );
  }
}
