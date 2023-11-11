import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication_api/authentication_api.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginPasswordHideCubit(),
      child: BlocBuilder<LoginPasswordHideCubit, bool>(builder: (context, hide) {
        return TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "Veuillez entrer un mot de passe";
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            filled: true,
            isDense: true,
            labelText: 'Mot de passe',
            suffixIcon: GestureDetector(
                onTap: () {
                  context.read<LoginPasswordHideCubit>().change();
                },
                child: Icon(hide ? Icons.visibility : Icons.visibility_off)),
          ),
          obscureText: hide,
        );
      }),);
  }
}
