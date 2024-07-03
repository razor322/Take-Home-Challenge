import 'package:flutter/material.dart';
import 'package:takehomechallenge/components/bottom_navigation.dart';
import 'package:takehomechallenge/screen/home_page.dart';
import 'package:takehomechallenge/screen/splashscren.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}
