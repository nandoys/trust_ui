import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:server_api/server_api.dart';
import 'package:trust_app/home//ui/view/view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {

    ActiveServerCubit activeServer = context.read<ActiveServerCubit>();

    return BlocListener<ActiveServerCubit, ActiveServerState>(
      listener: (context, currentServer) {
        context.read<ServerContextMenuCubit>().getServers();
      },
      child: RepositoryProvider(
        create: (context) => AuthenticationRepository(
            protocol: activeServer.state.protocol,
            host: activeServer.state.host,
            port: activeServer.state.port
        ),
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
      ),
    );
  }

}
