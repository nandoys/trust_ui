import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:user_api/user_api.dart';

class AdminSubmitForm extends StatelessWidget {
  const AdminSubmitForm({super.key, required this.formKey, required this.userController, required this.emailController,
    required this.passwordController, required this.organisation});

  final GlobalKey<FormState> formKey;
  final TextEditingController userController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Organisation organisation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmitCreateUserAdminFormLoadingCubit, bool>(builder: (context, loading) {
      return FilledButton(
        onPressed: !loading ? () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();

            final user = User(
                username: userController.text,
                email: emailController.text,
                password: passwordController.text,
                organisation: organisation
            );
            context.read<UserAdminCubit>().create(user);
            context.read<SubmitCreateUserAdminFormLoadingCubit>().change(true);
          }
        } : null,
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.blue),
        ),
        child: !loading ? const Text('Enregistrer') : const SizedBox(
          width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white,)
        ),
      );
    });
  }
}
