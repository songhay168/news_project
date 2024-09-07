import 'package:flutter/material.dart';
import 'package:news_project/module/logic/news_logic.dart';
import 'package:news_project/module/logic/search_logic.dart';
import 'package:news_project/module/main_screen.dart';
import 'package:provider/provider.dart';

Widget NewsAppWithProvider() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NewsLogic()),
      ChangeNotifierProvider(create: (context) => SearchLogic()),
    ],
    child: const NewsApp(),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'News App',
      home: const MainScreen(),
    );
  }
}
