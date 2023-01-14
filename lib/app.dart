import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:isometric8/app.dart';
import 'package:oo8/input.dart';

import 'package:oo8/widgets/clock.dart';

import 'models/app.dart';
import 'relay.dart';

class Oo8App extends StatefulWidget {
  Oo8Fractal app;

  Oo8App(this.app, {super.key});

  @override
  State<Oo8App> createState() => _Oo8AppState();
}

class _Oo8AppState extends State<Oo8App> {
  Oo8Fractal get app => widget.app;

  final list = <TextEditingController>[];
  insert([int pos = 0]) {
    setState(() {
      list.insert(
        pos,
        TextEditingController(),
      );
    });
  }

  final ctrl = TextEditingController();

  @override
  void initState() {
    insert();

    app.listen((event) {
      setState(() {});
    });
    super.initState();
  }

  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final padding = const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 8,
    );
    return Scaffold(
      body: SafeArea(
        child: IsometricArea(
          top: Container(
            padding: padding,
            alignment: Alignment.centerLeft,
            child: Row(children: [
              ClockField(),
              Expanded(
                child: Input8(
                  ctrl,
                  onSubmit: (value) {
                    if (value.startsWith('.')) {
                      app.search(
                        value.substring(1),
                      );
                    }
                    app.post(value);
                    ctrl.clear();
                  },
                ),
              ),
            ]),
          ),
          left: Column(
            children: [
              for (var i = 0; i < app.events.length; i++)
                Container(
                  padding: padding,
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      // timestamp
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            (app.events[i].createdAt.millisecondsSinceEpoch ~/
                                    1000)
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          center: Column(
            children: [
              for (var i = 0; i < app.events.length; i++)
                Container(
                  padding: padding,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        app.events[i].content,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          right: Column(
            children: [
              for (var i = 0; i < app.events.length; i++)
                Container(
                  padding: padding,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        app.events[i].id,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
