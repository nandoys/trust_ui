import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trust_app/logic/bloc/server/server.dart';
import 'package:trust_app/logic/bloc/server/server_bloc.dart';
import 'package:trust_app/ui/view/authentification/login_form.dart';
import 'package:trust_app/ui/view/authentification/status_bar.dart';

import 'package:trust_app/ui/view/server/get_server_loader.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  List<MenuItem> organisationMenu = [
    MenuItem(title: 'Nouvelle', action: 'create')
  ];

  @override
  Widget build(BuildContext context) {
    //getServer();
    return BlocProvider<ServerBloc>(
      create: (context) => ServerBloc()..add(const AppStartedEvent()),
      child: BlocBuilder<ServerBloc, ServerState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white60.withOpacity(0.4),
            body: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.65,
                child: const Card(
                  color: Colors.white,
                  elevation: 3,
                  child: LoginForm(),
                ),
              ),
            ),
            bottomNavigationBar: BlocProvider.value(
              value: context.read<ServerBloc>(),
              child: const StatusBar(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
