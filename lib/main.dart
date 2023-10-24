import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trust_app/ui/page/authentification/login.dart';


Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trust Compta',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue
      ),
      home: const LoginPage(),
    );
  }
}

