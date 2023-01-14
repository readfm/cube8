import 'package:flutter/material.dart';

class Input8 extends StatefulWidget {
  TextEditingController controller;
  final Function(String) onSubmit;
  Input8(this.controller, {required this.onSubmit, super.key});

  @override
  State<Input8> createState() => _Input8State();
}

class _Input8State extends State<Input8> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(8),
      ),
      controller: widget.controller,
      onFieldSubmitted: widget.onSubmit,
    );
  }
}
