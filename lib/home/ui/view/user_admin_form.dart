import 'package:flutter/material.dart';
import 'package:organization_api/organization_api.dart';

import 'package:trust_app/home/ui/widget/widget.dart';

class CreateUserAdminForm extends StatelessWidget {
  CreateUserAdminForm({super.key, required this.organization});

  final Organization organization;
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final verifyPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Créer un super utilisateur',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: UsernameField(controller: userController, organization: organization,),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AdminEmailField(controller: emailController, organization: organization,),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: PasswordField(controller: passwordController,),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: VerifyPasswordField(
              controller: verifyPasswordController,
              passwordController: passwordController,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AdminSubmitForm(
              formKey: _formKey,
              userController: userController,
              emailController: emailController,
              passwordController: passwordController,
              organization: organization,
            ),
          ),
        ],
      ),
    );
  }
}
