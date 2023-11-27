import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        keyboardType: TextInputType.phone,
        validator: ValidationBuilder(localeName: 'fr', optional: true).regExp(
            RegExp(r'^(\d+)$'), 'Veuillez entrer un numéro valide').phone(
            'Veuillez entrer un numéro valide').build(),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            filled: true,
            isDense: true,
            labelText: "Téléphone")
    );
  }
}
