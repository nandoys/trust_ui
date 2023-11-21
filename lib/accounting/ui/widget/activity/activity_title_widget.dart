import 'package:flutter/material.dart';

class ActivityTitleWidget extends StatelessWidget {
  const ActivityTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Vos produits',
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }
}
