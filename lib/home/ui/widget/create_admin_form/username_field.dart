import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_api/organisation_api.dart';

import 'package:trust_app/home/logic/cubit/cubit.dart';

class UsernameField extends StatelessWidget {
  UsernameField({super.key, required this.controller, required this.organisation});

  final TextEditingController controller;
  final Organisation organisation;
  final usernameKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckUsernameCubit, bool>(builder: (context, usernameExist) {
      return Focus(
          autofocus: true,
          onFocusChange: (focus){
            if(!focus) {
              if(controller.text.isNotEmpty) {
                context.read<CheckUsernameCubit>().checkField(organisation, controller.text);
              }
            }
          },
          child: TextFormField(
            key: usernameKey,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                filled: true,
                isDense: true,
                labelText: 'Utilisateur'),
            validator: (value) {
              if (value!.isEmpty) {
                return "Veuillez entrer un nom d'utilisateur";
              }
              if (usernameExist) {
                return "Cet utilisateur existe déjà";
              }
              return null;
            },
            onEditingComplete: () {
              if (usernameKey.currentState!.validate()) {
                FocusScope.of(context).nextFocus();
              }
            },
          ));
    });
  }
}