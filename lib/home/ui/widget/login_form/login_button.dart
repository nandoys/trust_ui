import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organization_api/organization_api.dart';
import 'package:server_api/server_api.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.usernameController, required this.passwordController,
    required this.formKey});

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SubmitLoginFormLoadingCubit, bool>(builder: (context, loading) {
      return BlocBuilder<ConnectivityStatusCubit, ConnectivityStatus>(builder: (context, connectivity) {
        if (connectivity == ConnectivityStatus.none) {
          return const Tooltip(
            message: "Veuillez choisir un serveur",
            child: FilledButton(
              onPressed: null,
              child: Text('Se connecter'),
            ),
          );
        }
        else if (connectivity == ConnectivityStatus.disconnected) {
          return const Tooltip(
            message: "Le serveur n'est pas connecté",
            child: FilledButton(
              onPressed: null,
              child: Text('Se connecter'),
            ),
          );
        }
        else {
          return BlocBuilder<ActiveOrganizationCubit, Organization?>(
              builder: (context, activeOrganisation) {

                if (activeOrganisation == null) {
                  context.read<SubmitLoginFormLoadingCubit>().change(false);
                  return const Tooltip(
                    message: "Veuillez choisir une organisation",
                    child: FilledButton(
                      onPressed: null,
                      child: Text('Se connecter'),
                    ),
                  );
                } else {
                  if (connectivity == ConnectivityStatus.disconnected) {
                    context.read<SubmitLoginFormLoadingCubit>().change(false);
                    return const Tooltip(
                      message: "Le serveur n'est pas connecté",
                      child: FilledButton(
                        onPressed: null,
                        child: Text('Se connecter'),
                      ),
                    );
                  }
                  return FilledButton(
                    onPressed: !loading ? () {
                      Organization? organisation = context.read<ActiveOrganizationCubit>().state;
                      if(formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        final authRepo = AuthenticationRepository(
                            protocol: context.read<ActiveServerCubit>().state.protocol,
                            host: context.read<ActiveServerCubit>().state.host,
                            port: context.read<ActiveServerCubit>().state.port
                        );
                        context.read<AuthenticationCubit>().login(
                            usernameController.text, passwordController.text, organisation, authRepo
                        );
                        context.read<SubmitLoginFormLoadingCubit>().change(true);
                      }
                    } : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
                    ),
                    child: !loading ? const Text('Se connecter') : const SizedBox(
                        width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white,)),
                  );
                }
              }
          );
        }
      });
    });
  }
}
