import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:user_api/user_api.dart';
import 'package:organisation_api/organisation_api.dart';

import 'package:trust_app/home/logic/cubit/cubit.dart';
import 'package:trust_app/home//ui/view/view.dart';
import 'package:trust_app/home/ui/widget/widget.dart';
import 'package:trust_app/utils.dart';


class CreateUserAdminPage extends StatelessWidget {
  const CreateUserAdminPage({super.key, required this.organisation});

  final Organisation organisation;

  @override
  Widget build(BuildContext context) {
    ActiveServerCubit activeServer = context.read<ActiveServerCubit>();

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => UserRepository(
              protocol: activeServer.state.protocol,
              host: activeServer.state.host,
              port: activeServer.state.port)
          )
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => UserFieldApiStatusCubit()),
              BlocProvider(create: (context) => CheckUsernameCubit(
                  userRepository: context.read<UserRepository>(),
                  connectivityStatus: context.read<ConnectivityStatusCubit>(),
                  apiStatus: context.read<UserFieldApiStatusCubit>()
              )),
              BlocProvider(create: (context) => EmailFieldApiStatusCubit()),
              BlocProvider(create: (context) => CheckEmailCubit(
                  userRepository: context.read<UserRepository>(),
                  connectivityStatus: context.read<ConnectivityStatusCubit>(),
                  apiStatus: context.read<UserFieldApiStatusCubit>()
              )),
              BlocProvider(create: (context) => PasswordHideCubit()),
              BlocProvider(create: (context) => CreateAdminUserApiStatusCubit()),
              BlocProvider(create: (context) => SubmitCreateUserAdminFormLoadingCubit()),
              BlocProvider(create: (context) => UserAdminCubit(
                userRepository: context.read<UserRepository>(),
                connectivityStatus: context.read<ConnectivityStatusCubit>(),
                apiStatus: context.read<CreateAdminUserApiStatusCubit>()
                // activeOrganisationCubit: context.read<ActiveOrganisationCubit>()
              )),
            ],
            child: MultiBlocListener(
                listeners: [
                  BlocListener<UserAdminCubit, User?>(
                    listener: (context, user){
                      context.read<SubmitCreateUserAdminFormLoadingCubit>().change(false);
                      if(user != null) {
                        context.read<ActiveOrganisationCubit>().setCurrent(organisation);
                        context.goNamed('start', extra: user);
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
                        child: CreateUserAdminForm(organisation: organisation,),
                      ),
                    ),
                  ),
                )
            ),
        )
    );
  }
}
