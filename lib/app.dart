import 'package:flutter/material.dart';
import 'package:trust_app/authentification/ui/page/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trust Compta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,

      ),
      home: const LoginPage(),
    );
  }
}