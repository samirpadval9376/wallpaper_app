import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controllers/api_controller.dart';
import 'package:wallpaper_app/utils/my_page_route_utils.dart';
import 'package:wallpaper_app/views/screens/detail_page.dart';
import 'package:wallpaper_app/views/screens/favourite_page.dart';
import 'package:wallpaper_app/views/screens/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApiController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      routes: {
        MyPageRoute.home: (context) => HomePage(),
        MyPageRoute.detailPage: (context) => DetailPage(),
        MyPageRoute.favouritePage: (context) => FavouritePage(),
      },
    );
  }
}
