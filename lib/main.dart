import 'package:flutter/material.dart';
import 'package:bloc_practice/BlBlocCounterPage.dart';
import 'package:bloc_practice/ListViewBloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListViewBloc(),
      // home: BlBlocCounterPage(),
    );
  }
}

