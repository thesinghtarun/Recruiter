import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recruiter/helper/ui_helper.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getCustomTheme(context),
      home: const Scaffold(
        body: Center(
          child: Text("search"),
        ),
      ),
    );
  }

  ThemeData getCustomTheme(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return ThemeData(
        brightness: Brightness.light,
        backgroundColor: const Color.fromARGB(255, 255, 230, 200),
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
        ),
      );
    }
  }
}
