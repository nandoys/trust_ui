import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_api/organisation_api.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.usernameController, required this.passwordController,
    required this.formKey});

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmitLoginFormLoadingCubit, bool>(builder: (context, loading) {
      return FilledButton(
        onPressed: !loading ? () {
          Organisation? organisation = context.read<ActiveOrganisationCubit>().state;
          if(formKey.currentState!.validate()) {
            formKey.currentState?.save();
            context.read<AuthenticationCubit>().login(
                usernameController.text, passwordController.text, organisation
            );
            context.read<SubmitLoginFormLoadingCubit>().change(true);
          }
        } : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
        ),
        child: !loading ? const Text('Se connecter') : const SizedBox(
            width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white,)
        ),
      );
    });
  }
}
