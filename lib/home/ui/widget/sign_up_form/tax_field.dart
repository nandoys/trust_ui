import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class TaxField extends StatelessWidget {
  const TaxField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: ValidationBuilder(localeName: 'fr', optional: true).regExp(
            RegExp(r'^[a-zA-Z0-9/.\s-]+$'),
            'Veuillez entrer un numéro valide [a-z A-Z 0-9 . -/]'
        ).build(),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            filled: true,
            isDense: true,
            labelText: "Numéro Impôt")
    );
  }
}
