import 'package:flutter/material.dart';

class FloatingSnackBar extends SnackBar {
  FloatingSnackBar({super.key, required this.color, required this.message,}):
  super(
        width: 450.0,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: color,
      );

  final Color color;
  final String message;

}
