
import 'dart:math';

import 'package:flutter/material.dart';
import '../models/profileUserModel.dart';
import '../main.dart';
import 'package:intl/intl.dart';
import '../screens/navBar.dart';

class editingTextField extends StatefulWidget{
  final int maxLines;
  final String existingText;
  final ValueChanged<String> onChanged;
  TextEditingController controller;

  editingTextField({
    Key? key,
    this.maxLines = 1,
    required this.existingText,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  _editTextFieldState createState() => _editTextFieldState();
}


class _editTextFieldState extends State<editingTextField>{
  late final TextEditingController controller/* = widget.controller*/;

  @override
  void initState(){
    super.initState();

    controller = TextEditingController(text: widget.existingText);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 5),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        maxLines: widget.maxLines,
      )
    ]
  );

}
