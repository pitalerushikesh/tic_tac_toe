import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;
  const CustomDialog({
    required this.title,
    required this.content,
    this.actionText = "Play Again",
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: callback,
          child: Text(
            actionText,
          ),
        ),
      ],
    );
  }
}
