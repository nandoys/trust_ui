import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        validator: ValidationBuilder(localeName: 'fr', optional: true).email(
            'Veuillez entrer une adresse valide'
        ).build(),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            filled: true,
            isDense: true,
            labelText: "Adresse email")
    );
  }
}
