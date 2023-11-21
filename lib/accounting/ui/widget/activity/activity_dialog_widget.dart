import 'package:flutter/material.dart';

class ActivityDialog extends StatelessWidget {
  const ActivityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: SizedBox(
        width: 850,
        height: 600,
        child: Column(
          children: [Text('data')],
        ),
      ),
    );
  }
}
