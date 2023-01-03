import 'package:flutter/material.dart';
import 'package:oo8/input.dart';

class Oo8App extends StatefulWidget {
  const Oo8App({super.key});

  @override
  State<Oo8App> createState() => _Oo8AppState();
}

class _Oo8AppState extends State<Oo8App> {
  final list = <TextEditingController>[];
  insert([int pos = 0]) {
    setState(() {
      list.insert(
        pos,
        TextEditingController(),
      );
    });
  }

  @override
  void initState() {
    insert();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            for (var i = 0; i < list.length; i++)
              Input8(
                list[i],
                onSubmit: (value) {
                  insert(i);
                },
              ),
          ],
        ),
      ),
    );
  }
}
