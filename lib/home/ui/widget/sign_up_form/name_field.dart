import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  const NameField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: true,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "Veuillez entrer le nom de votre organisation";
          }

          return null;
        },
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            filled: true,
            isDense: true,
            labelText: "Nom de l'organisation*")
    );
  }
}
