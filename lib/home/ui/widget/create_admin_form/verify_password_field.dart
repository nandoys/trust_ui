import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_api/user_api.dart';

class VerifyPasswordField extends StatelessWidget {
  VerifyPasswordField({super.key, required this.controller, required this.passwordController});

  final TextEditingController controller;
  final TextEditingController passwordController;
  final passwordKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordHideCubit, bool>(builder: (context, hide) {
      return TextFormField(
        key: passwordKey,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
          contentPadding:
          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          filled: true,
          isDense: true,
          labelText: 'Validation mot de passe',
        ),
        validator: (value) {
          if (controller.text != passwordController.text) {
            return "Le mot de passe ne correspond pas";
          }
          return null;
        },
        obscureText: hide,
      );
    });
  }
}
