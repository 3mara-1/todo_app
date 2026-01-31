import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({
    super.key,
    required this.isCompleted,
    required this.onChanged,
  });
  bool? isCompleted;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isCompleted,
      onChanged: (value) => onChanged(value),
      activeColor: Color(0xff15B86C),
    );
  }
}
