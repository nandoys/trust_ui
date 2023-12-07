import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class AccountNumberField extends StatelessWidget {
  const AccountNumberField({super.key, required this.controller, required this.enable});

  final TextEditingController controller;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: enable,
          controller: controller,
          validator: ValidationBuilder(
              requiredMessage: 'Numéro de compte obligatoire'
          ).regExp(RegExp(r'^[0-9]+$'), 'Numéro invalide').build(),
          decoration: const InputDecoration(
            label: Text("Numéro de compte*"),
          ),
        ),
      ),
    );
  }
}
