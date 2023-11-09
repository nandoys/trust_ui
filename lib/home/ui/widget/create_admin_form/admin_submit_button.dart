import 'package:flutter/material.dart';

class AdminSubmitForm extends StatelessWidget {
  const AdminSubmitForm({super.key, required this.formKey, required this.userController, required this.emailController,
    required this.passwordController});

  final GlobalKey<FormState> formKey;
  final TextEditingController userController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          print('pressed');
        }
      },
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.resolveWith((states) => Colors.blue),
      ),
      child: const Text('Enregistrer'),
    );
  }
}
