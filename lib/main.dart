import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:public_games/screens/home/add_game.dart';
import 'package:public_games/screens/home/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: GoogleFonts.kanit().fontFamily,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        AddgamePage.routeName: (context) => AddgamePage(),
      },
    );
  }
}

