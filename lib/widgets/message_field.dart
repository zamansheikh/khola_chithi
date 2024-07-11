import 'package:flutter/material.dart';

class MessageField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? expandable;

  const MessageField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.expandable = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(hintText),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      maxLines: expandable! ? 3 : 1,
    );
  }
}
