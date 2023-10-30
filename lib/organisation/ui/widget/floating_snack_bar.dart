import 'package:flutter/material.dart';

class FloatingSnackBar extends SnackBar {
  FloatingSnackBar({super.key, required this.color, required this.message,
    this.messageDuration = const Duration(seconds: 4)}):
  super(
        width: 450.0,
        showCloseIcon: true,
        duration: messageDuration,
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: color,
      );

  final Color color;
  final String message;
  final Duration messageDuration;

}
