import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:organisation_api/organisation_api.dart';

import 'package:server_api/server_api.dart';
import 'package:trust_app/home/ui/view/view.dart';
import 'package:trust_app/home/ui/widget/widget.dart';
import 'package:user_api/user_api.dart';
import 'package:utils/utils.dart';

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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => OrganisationApiStatusCubit()),
          BlocProvider(create: (context) => UserRoleApiStatusCubit()),
        ],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
            create: (context) => AuthenticationRepository(
                protocol: activeServer.state.protocol,
                host: activeServer.state.host,
                port: activeServer.state.port
            ),
          ),
            RepositoryProvider(
              create: (context) => OrganisationRepository(
                  protocol: context.read<ActiveServerCubit>().state.protocol,
                  host: context.read<ActiveServerCubit>().state.host,
                  port: context.read<ActiveServerCubit>().state.port
              )
            ),
            RepositoryProvider(create: (context) => UserRepository(
                protocol: activeServer.state.protocol,
                host: activeServer.state.host,
                port: activeServer.state.port))
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => OrganisationContextMenuCubit(
                      organisationRepository: context.read<OrganisationRepository>(),
                      connectivityStatus: context.read<ConnectivityStatusCubit>(),
                      apiStatus: context.read<OrganisationApiStatusCubit>()
                  )..get()
              ),
              BlocProvider(
                  create: (context) => SetupOrganisationCubit()
              ),
              BlocProvider(
                  create: (context) => ActiveOrganisationCubit(
                      organisationMenu: context.read<OrganisationContextMenuCubit>(),
                      organisationRepository: context.read<OrganisationRepository>(),
                      connectivityStatus: context.read<ConnectivityStatusCubit>(),
                      apiStatus: context.read<UserRoleApiStatusCubit>(),
                      setup: context.read<SetupOrganisationCubit>()
                  )
              ),
              BlocProvider(create: (context) => LoginApiStatusCubit()),
              BlocProvider(create: (context) => UserCubit(
                  userRepository: context.read<UserRepository>(),
                  connectivityStatus: context.read<ConnectivityStatusCubit>(),
                  apiStatus: context.read<LoginApiStatusCubit>()
                // activeOrganisationCubit: context.read<ActiveOrganisationCubit>()
              )),
              BlocProvider(create: (context) => SubmitLoginFormLoadingCubit()),
              BlocProvider(create: (context) => AuthenticationCubit(
                  authenticationRepository: context.read<AuthenticationRepository>(),
                  connectivityStatus: context.read<ConnectivityStatusCubit>(),
                  apiStatus: context.read<LoginApiStatusCubit>(),
                  userCubit: context.read<UserCubit>()
              )),
            ],
            child: MultiBlocListener(
              listeners: [
                BlocListener<LoginApiStatusCubit, ApiStatus>(
                  listener: (context, apiStatus){
                    context.read<SubmitLoginFormLoadingCubit>().change(false);
                    final authStatus = context.read<AuthenticationCubit>().state;
                    final user = context.read<UserCubit>().state;

                    if(user != null && authStatus == AuthenticationStatus.authenticated) {
                      context.goNamed('start', extra: user);
                    }

                    else if(user == null && authStatus == AuthenticationStatus.unauthenticated) {

                      SnackBar notif = FloatingSnackBar(
                          color: Colors.red,
                          message: "Utilisateur et/ou Mot de passe incorrect!"
                      );
                      ScaffoldMessenger.of(context).showSnackBar(notif);
                    }
                  },
                  listenWhen: (previous, current) => current != ApiStatus.requesting,
                ),
              ],
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
                      child: LoginForm(),
                    ),
                  ),
                ),
                bottomNavigationBar: const StatusBar(),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
