import 'package:ani4h_app/pages/first_page.dart';
import 'package:ani4h_app/pages/home_page.dart';
import 'package:ani4h_app/pages/second_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/homepage': (context) => const HomePage(),
        '/firstpage': (context) => const FirstPage(),
        '/secondpage': (context) => const SecondPage(),
      },
      initialRoute: '/homepage',
    );
  }
}