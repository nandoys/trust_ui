import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white60.withOpacity(0.4),
        body: Center(
          child: SizedBox.fromSize(
            size: Size(width * 0.80, height * 0.80),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  AppBar(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)
                  ),)
                ],
              ),
            ),
          ),
        )
    );
  }
}
