import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isometric8/app.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:oo8/input.dart';

import 'package:oo8/widgets/clock.dart';

import 'db/main.dart';
import 'db/shared.dart';
import 'models/app.dart';
import 'relay.dart';
import 'utils/linkify.dart';

class Oo8App extends StatefulWidget {
  Oo8Fractal app;

  Oo8App(this.app, {super.key});

  @override
  State<Oo8App> createState() => _Oo8AppState();
}

class _Oo8AppState extends State<Oo8App> {
  Oo8Fractal get app => widget.app;

  final list = <TextEditingController>[];

  final ctrl = TextEditingController();

  List<Event> events = [];

  @override
  void initState() {
    /*
    app.listen((event) {
      setState(() {});
    });
    */
    init();
    super.initState();
  }

  init() async {
    final select = db.select(db.events)
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ])
      ..limit(100);
    select.watch().listen((events) {
      setState(() {
        this.events = events;
      });
    });
  }

  final focus = FocusNode();

  // gravity is our present moment, everything else is electromagnetic potential synchronizing into

  @override
  Widget build(BuildContext context) {
    final padding = const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 8,
    );

    return Scaffold(
      body: SafeArea(
        child: IsometricArea(
          left: Column(
            children: [
              ClockField(),
              for (var i = 0; i < events.length; i++)
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
                            (events[i].createdAt).toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
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
          center: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: padding,
                  alignment: Alignment.centerLeft,
                  child: Row(children: [
                    Expanded(
                      child: Input8(
                        ctrl,
                        onSubmit: (value) {
                          if (value.startsWith('.')) {
                            app.search(
                              value.substring(1),
                            );
                          }
                          ctrl.clear();
                          app.post(value);
                        },
                      ),
                    ),
                  ]),
                ),
                ...events.map(
                  (event) => Container(
                    padding: padding,
                    child: Linkify(
                      onOpen: (link) async {},
                      text: event.content,
                      style: TextStyle(color: Color.fromARGB(255, 64, 64, 64)),
                      linkStyle:
                          TextStyle(color: Color.fromARGB(255, 54, 57, 244)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          right: Container(
            child: Column(
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
          bottom: Row(children: [
            SvgPicture.string(
              Jdenticon.toSvg('Your input string'),
              fit: BoxFit.contain,
              height: 64,
              width: 64,
            ),
            SvgPicture.string(
              Jdenticon.toSvg('another '),
              fit: BoxFit.contain,
              height: 64,
              width: 64,
            ),
            /*
            SvgPicture.string(
              Jdenticon.toSvg('string'),
              fit: BoxFit.contain,
              height: 64,
              width: 64,
            ),
            SvgPicture.string(
              Jdenticon.toSvg('asdf string'),
              fit: BoxFit.contain,
              height: 64,
              width: 64,
            ),
            **/
          ]),
        ),
      ),
    );
  }
}
