import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/app_size.dart';

// ignore: must_be_immutable
class CustomTextFormFiled extends StatelessWidget {
  CustomTextFormFiled({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText,
    this.maxLines,
    required this.title,
  });
  final String title;
  final TextEditingController controller;
  String? Function(String?)? validator;
  final String hintText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: AppSize.h8),
        TextFormField(
          controller: controller,
          validator: validator,
          style: Theme.of(context).textTheme.labelMedium,

          maxLines: maxLines,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
