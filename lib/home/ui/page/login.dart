import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/home//ui/view/view.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

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

    return BlocListener<ActiveServerCubit, String?>(
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
