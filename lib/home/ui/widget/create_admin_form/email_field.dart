import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:user_api/user_api.dart';

class AdminEmailField extends StatelessWidget {
  AdminEmailField({super.key, required this.controller, required this.organisation});

  final TextEditingController controller;
  final Organisation organisation;
  final emailKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckEmailCubit, bool>(builder: (context, emailExist) {
      return Focus(
          onFocusChange: (focus){
            if(!focus) {
              if(controller.text.isNotEmpty) {
                context.read<CheckEmailCubit>().checkField(organisation, controller.text);
              }
            }
          },
          child: TextFormField(
            key: emailKey,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                filled: true,
                isDense: true,
                labelText: 'Adresse email'),
            validator: ValidationBuilder(localeName: 'fr', requiredMessage: 'Veuillez entrer une adresse email').email(
                'Veuillez entrer une adresse valide'
            ).add((value) {
              if (emailExist) {
                return "Cette adresse email existe déjà";
              }
              return null;
            }).build(),
            onEditingComplete: () {
              if (emailKey.currentState!.validate()) {
                FocusScope.of(context).nextFocus();
              }
            },
          ));
    });
  }
}
