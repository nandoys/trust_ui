import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:server_api/server_api.dart';
import 'package:user_api/user_api.dart';
import 'package:organization_api/organization_api.dart';

import 'package:trust_app/home//ui/view/view.dart';
import 'package:trust_app/home/ui/widget/widget.dart';
import 'package:utils/utils.dart';


class CreateUserAdminPage extends StatelessWidget {
  const CreateUserAdminPage({super.key, required this.organization});

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    ActiveServerCubit activeServer = context.read<ActiveServerCubit>();

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => UserRepository(
              protocol: activeServer.state.protocol,
              host: activeServer.state.host,
              port: activeServer.state.port))
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => UserFieldApiStatusCubit()),
              BlocProvider(create: (context) => CheckUsernameCubit(
                  repository: context.read<UserRepository>(),
                  connectivityStatus: context.read<ConnectivityStatusCubit>(),
                  apiStatus: context.read<UserFieldApiStatusCubit>()
              )),
              BlocProvider(create: (context) => EmailFieldApiStatusCubit()),
              BlocProvider(create: (context) => CheckEmailCubit(
                  repository: context.read<UserRepository>(),
                  connectivityStatus: context.read<ConnectivityStatusCubit>(),
                  apiStatus: context.read<UserFieldApiStatusCubit>()
              )),
              BlocProvider(create: (context) => PasswordHideCubit()),
              BlocProvider(create: (context) => CreateAdminUserApiStatusCubit()),
              BlocProvider(create: (context) => SubmitCreateUserAdminFormLoadingCubit()),
              BlocProvider(create: (context) => UserCubit(
                  repository: context.read<UserRepository>(),
                connectivityStatus: context.read<ConnectivityStatusCubit>(),
                apiStatus: context.read<CreateAdminUserApiStatusCubit>()
              )),
            ],
            child: MultiBlocListener(
                listeners: [
                  BlocListener<UserCubit, User?>(
                    listener: (context, user){
                      context.read<SubmitCreateUserAdminFormLoadingCubit>().change(false);
                      if(user != null) {
                        context.read<ActiveOrganizationCubit>().setCurrent(
                            organization,
                            OrganizationRepository(
                                protocol: context.read<ActiveServerCubit>().state.protocol,
                                host: context.read<ActiveServerCubit>().state.host,
                                port: context.read<ActiveServerCubit>().state.port
                            )
                        );
                        context.goNamed('start', extra: {
                          'user': user, 'organizationContextMenuCubit': context.read<OrganizationContextMenuCubit>()
                        });
                      }
                    },
                  ),
                  BlocListener<CreateAdminUserApiStatusCubit, ApiStatus>(
                      listener: (context, apiStatus){
                        SnackBar notif = FloatingSnackBar(
                            color: Colors.red,
                            message: "Impossible de créer un super utilisateur."
                        );
                        ScaffoldMessenger.of(context).showSnackBar(notif);
                        context.read<SubmitCreateUserAdminFormLoadingCubit>().change(false);
                      },
                      listenWhen: (previous, current) => current == ApiStatus.failed
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
                        child: CreateUserAdminForm(organization: organization,),
                      ),
                    ),
                  ),
                )
            ),
        )
    );
  }
}
