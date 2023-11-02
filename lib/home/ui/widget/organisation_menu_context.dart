import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:native_context_menu/native_context_menu.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';
import 'package:trust_app/utils.dart';

import 'floating_snack_bar.dart';

class OrganisationContextMenu extends StatelessWidget {
  const OrganisationContextMenu({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => OrganisationApiStatusCubit(),
      child: RepositoryProvider(
        create: (context) => OrganisationRepository(
            protocol: context.read<ActiveServerCubit>().state.protocol,
            host: context.read<ActiveServerCubit>().state.host,
            port: context.read<ActiveServerCubit>().state.port
        ),
        child: BlocProvider(
          create: (context) => OrganisationContextMenuCubit(
              organisationRepository: context.read<OrganisationRepository>(),
              connectivityStatus: context.read<ConnectivityStatusCubit>(),
              apiStatus: context.read<OrganisationApiStatusCubit>()
          )..get(),
          child: BlocProvider(
            create: (context) => ActiveOrganisationCubit(
                organisationMenu: context.read<OrganisationContextMenuCubit>()
            ),
            child: BlocBuilder<OrganisationContextMenuCubit, List<MenuItem>>(
                builder: (context, menus) {
                  String? protocol;
                  String? host;
                  String? port;

                  return BlocListener<OrganisationApiStatusCubit, ApiStatus>(
                    listener: (context, apiStatus) {
                      if (apiStatus == ApiStatus.failed) {
                        SnackBar notif = FloatingSnackBar(
                            color: Colors.red,
                            messageDuration: const Duration(seconds: 8),
                            message: "Impossible de récupérer la liste des organisations, veuillez informer le concepteur"
                        );
                        ScaffoldMessenger.of(context).showSnackBar(notif);
                      }
                    },
                    child: ContextMenuRegion(
                      onDismissed: () => {},
                      onItemSelected: (item) => {
                        if (item.action == 'create') {
                          protocol = context.read<ActiveServerCubit>().state.protocol,
                          host = context.read<ActiveServerCubit>().state.host,
                          port = context.read<ActiveServerCubit>().state.port,
                          context.goNamed('organisation.signUp', queryParameters: {
                            'protocol': protocol, 'host':host, 'port': port
                          }, extra: context.read<OrganisationRepository>())
                        } else if (item.action is Organisation) {
                          context.read<ActiveOrganisationCubit>().active(item.action as Organisation)
                        }
                      },
                      menuItems: menus,
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: SizedBox(
                              height: 20,
                              width: 20,
                              child: Container(
                                  color: Colors.purple.shade300,
                                  child: const Center(
                                    child: Text(
                                        'F',
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w500,
                                        )
                                    ),
                                  )
                              )
                          ),
                          label: const Text(
                            'organisation',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0),
                          ),
                          style: ButtonStyle(
                              iconSize: MaterialStateProperty.resolveWith((states) => 15.0),
                              iconColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
                              overlayColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade900)
                          )
                      ),
                    ),
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}
