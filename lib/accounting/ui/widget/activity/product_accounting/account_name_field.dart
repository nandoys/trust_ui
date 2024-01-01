import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class AccountNameField extends StatelessWidget {
  const AccountNameField({super.key, required this.controller, this.saveAccount, required this.enable,
  required this.isLoading});

  final TextEditingController controller;
  final bool enable;
  final VoidCallback? saveAccount;
  final bool isLoading;

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
              suffixIcon: isLoading ? CircularProgressIndicator(
                color: Colors.blue.shade700,
                strokeWidth: 3,
              ) : IconButton(
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
