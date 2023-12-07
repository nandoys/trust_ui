import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class AccountNameField extends StatelessWidget {
  const AccountNameField({super.key, required this.controller, this.saveAccount, required this.enable});

  final TextEditingController controller;
  final bool enable;
  final VoidCallback? saveAccount;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 10.0),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          enabled: enable,
          validator: ValidationBuilder(
              requiredMessage: 'Intitulé de compte obligatoire'
          ).build(),
          decoration: InputDecoration(
              label: const Text("Intitulé de compte*"),
              suffixIcon: IconButton(
                onPressed: saveAccount,
                icon: const Icon(Icons.send),
                tooltip: "Ajouter",
              )
          ),
        ),
      ),
    );
  }
}
