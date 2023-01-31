import 'package:flutter/material.dart';
import 'package:oo8/db/shared.dart';

import 'app.dart';
import 'models/app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Oo8Fractal app;

  @override
  void initState() {
    app = Oo8Fractal();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oo8',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Oo8App(app),
    );
  }
}
