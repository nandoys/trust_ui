import 'package:flutter/material.dart';

import 'package:trust_app/home/ui/widget/widget.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController(text: 'grnandoy');

  final _passwordController = TextEditingController(text: '@Bc12345');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Connexion',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: LoginUsernameField(controller: _usernameController),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: LoginPasswordField(controller: _passwordController,),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: LoginButton(
              formKey: _formKey,
              usernameController: _usernameController,
              passwordController: _passwordController,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
