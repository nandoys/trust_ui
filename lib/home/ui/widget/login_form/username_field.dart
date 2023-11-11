import 'package:flutter/material.dart';

class LoginUsernameField extends StatelessWidget {
  const LoginUsernameField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Veuillez entrer un utilisateur";
        }
        return null;
      },
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          filled: true,
          isDense: true,
          labelText: 'Utilisateur'),
    );
  }
}
