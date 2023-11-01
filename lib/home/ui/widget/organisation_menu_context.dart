import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

class OrganisationContextMenu extends StatelessWidget {
  const OrganisationContextMenu({super.key});

  @override
  Widget build(BuildContext context) {

    return RepositoryProvider(
      create: (context) => OrganisationRepository(
          protocol: context.read<ActiveServerCubit>().state.protocol,
          host: context.read<ActiveServerCubit>().state.host,
          port: context.read<ActiveServerCubit>().state.port
      ),
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ActiveOrganisationCubit(
                  organisationRepository: context.read<OrganisationRepository>()
              ),
            ),
            BlocProvider(
              create: (context) => OrganisationContextMenuCubit(
                  organisationRepository: context.read<OrganisationRepository>(),
                  activeOrganisation: context.read<ActiveOrganisationCubit>(),
                  connectivityStatus: context.read<ConnectivityStatusCubit>()
              )..get(),
            )
          ],
          child: BlocBuilder<OrganisationContextMenuCubit, List<MenuItem>>(
              builder: (context, menus) {
                return ContextMenuRegion(
                    onDismissed: () => {},
                    onItemSelected: (item) => {
                  if (item.action == 'create') {
                    //context.goNamed('organisation.signUp')
                  }
                },
                    menuItems: menus,
                    child: TextButton.icon(
                      onPressed: () {
                        print(context.read<OrganisationRepository>().protocol);
                      },
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
                    )
                );
              }
          )
      ),
    );
  }
}
