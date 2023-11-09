import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

import 'package:trust_app/home/logic/cubit/cubit.dart';

class PasswordField extends StatelessWidget {
  PasswordField({super.key, required this.controller});

  final TextEditingController controller;
  final passwordKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordHideCubit, bool>(builder: (context, hide) {
      return Focus(
          child: TextFormField(
            key: passwordKey,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              filled: true,
              isDense: true,
              labelText: 'Mot de passe',
              suffixIcon: GestureDetector(
                  onTap: () {
                    context.read<PasswordHideCubit>().change();
                  },
                  child: Icon(hide ? Icons.visibility : Icons.visibility_off)
              ),
            ),
            obscureText: hide,
            validator: ValidationBuilder(localeName: 'fr', requiredMessage: 'Veuillez entrer un mote de passe').
            minLength(8, "Doit avoir au moins 8 caractères").regExp(
                RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)+'),
                'Doit contenir une majuscule, minuscule, un chiffre et un caractère spécial').build(),
            onEditingComplete: () {
              if (passwordKey.currentState!.validate()) {
                FocusScope.of(context).nextFocus();
              }
            },
      )
      );
    });
  }
}
