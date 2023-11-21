import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:server_api/server_api.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:utils/utils.dart';

import 'floating_snack_bar.dart';

class OrganisationContextMenu extends StatelessWidget {
  const OrganisationContextMenu({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<OrganisationContextMenuCubit, List<MenuItem>>(
        listener: (context, menus) {
          if(menus.length > 1) {
            context.read<ActiveOrganisationCubit>().getCurrent(OrganisationRepository(
                protocol: context.read<ActiveServerCubit>().state.protocol,
                host: context.read<ActiveServerCubit>().state.host,
                port: context.read<ActiveServerCubit>().state.port
            ));
          }
          else if (menus.length == 1) {
            context.read<ActiveOrganisationCubit>().removeCurrent(OrganisationRepository(
                protocol: context.read<ActiveServerCubit>().state.protocol,
                host: context.read<ActiveServerCubit>().state.host,
                port: context.read<ActiveServerCubit>().state.port
            ));
          }
        },
        builder: (context, menus) {
          String? protocol;
          String? host;
          int? port;
          ActiveOrganisationCubit activeOrganisation = context.read<ActiveOrganisationCubit>();

          return MultiBlocListener(
            listeners: [
              BlocListener<OrganisationApiStatusCubit, ApiStatus>(
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
              ),
              BlocListener<UserRoleApiStatusCubit, ApiStatus>(
                listener: (context, apiStatus) {
                  if (apiStatus == ApiStatus.failed) {
                    SnackBar notif = FloatingSnackBar(
                        color: Colors.red,
                        messageDuration: const Duration(seconds: 8),
                        message: "Impossible de communiquer avec l'api, pour vérifier votre organisation"
                    );
                    ScaffoldMessenger.of(context).showSnackBar(notif);
                  }
                },
              ),
              BlocListener<ActiveOrganisationCubit, Organisation?>(
                listener: (context, organisation) {
                  context.read<ActiveOrganisationCubit>().setCurrent(
                      organisation,
                      OrganisationRepository(
                      protocol: context.read<ActiveServerCubit>().state.protocol,
                      host: context.read<ActiveServerCubit>().state.host,
                      port: context.read<ActiveServerCubit>().state.port
                  )
                  );
                },
                listenWhen: (previous, current) => current != null,
              ),
              BlocListener<SetupOrganisationCubit, Organisation?>(
                listener: (context, organisation) {
                  context.goNamed('createAdmin', extra: {
                    'organisation': organisation,
                    'activeOrganisationCubit': context.read<ActiveOrganisationCubit>(),
                    'organisationContextMenuCubit': context.read<OrganisationContextMenuCubit>()
                  });
                },
                listenWhen: (previous, current) => current != null,
              )
            ],
            child: ContextMenuRegion(
              onDismissed: () => {},
              onItemSelected: (item) => {
                if (item.action == 'create') {
                  protocol = context.read<ActiveServerCubit>().state.protocol,
                  host = context.read<ActiveServerCubit>().state.host,
                  port = context.read<ActiveServerCubit>().state.port,
                  context.goNamed('signUp', queryParameters: {
                    'protocol': protocol, 'host':host, 'port': port.toString()
                  }, extra: {
                    'activeOrganisationCubit': context.read<ActiveOrganisationCubit>(),
                    'organisationContextMenuCubit': context.read<OrganisationContextMenuCubit>()
                  })
                } else if (item.action is Organisation) {
                  activeOrganisation.active(
                      item.action as Organisation,
                      OrganisationRepository(
                          protocol: context.read<ActiveServerCubit>().state.protocol,
                          host: context.read<ActiveServerCubit>().state.host,
                          port: context.read<ActiveServerCubit>().state.port
                      )
                  )
                }
              },
              menuItems: menus,
              child: BlocBuilder<ActiveOrganisationCubit, Organisation?>(builder: (context, organisation) {
                return TextButton.icon(
                    onPressed: () {},
                    icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: Container(
                            color: Colors.blue.shade900,
                            child: Center(
                              child: Text(
                                  activeOrganisation.state?.name.substring(0, 1) ?? 'A',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  )
                              ),
                            )
                        )
                    ),
                    label: Text(
                      activeOrganisation.state?.name ?? 'Aucune organisation',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0
                      ),
                    ),
                    style: ButtonStyle(
                        iconSize: MaterialStateProperty.resolveWith((states) => 15.0),
                        iconColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                        overlayColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade900)
                    )
                );
              }),
            ),
          );
        }
    );
  }
}
