import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/organisation//ui/view/login_form.dart';
import 'package:trust_app/organisation//ui/view/status_bar.dart';
import 'package:trust_app/organisation/logic/cubit/server/context_menu/context_menu_cubit.dart';
import 'package:trust_app/organisation/logic/cubit/server/context_server/context_server_cubit.dart';

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

    return BlocListener<ContextServerCubit, String?>(
      listener: (context, currentServer) {
        context.read<ServerContextMenuCubit>().getServers();
      },
      child: Scaffold(
      backgroundColor: Colors.white60.withOpacity(0.4),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * 0.65,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0)
            ),
            child: const LoginForm(),
          ),
        ),
      ),
      bottomNavigationBar: const StatusBar(),
    ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
