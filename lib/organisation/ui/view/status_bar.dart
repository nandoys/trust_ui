import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/organisation/logic/cubit/server/connectivity/connectivity_status_cubit.dart';
import 'package:trust_app/organisation/ui/widget/organisation_menu_context.dart';
import 'package:trust_app/organisation/ui/widget/server_menu_context.dart';
import 'package:trust_app/organisation/logic/cubit/server/context_server/context_server_cubit.dart';

import 'package:trust_app/organisation/ui/widget/floating_snack_bar.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({super.key});

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  List<MenuItem> serverMenu = [MenuItem(title: 'Nouveau', action: 'create')];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27,
      child: Container(
        color: Colors.black,
        child: MultiBlocListener(listeners: [
          BlocListener<ContextServerCubit, String?>(listener: (context, current_server) {}),
          BlocListener<ConnectivityStatusCubit, ConnectivityStatus>(listener: (context, status) {
            if (status == ConnectivityStatus.connected) {
              SnackBar notif = FloatingSnackBar(
                  color: Colors.green,
                  message: "La connexion avec le serveur établie avec succès"
              );

              ScaffoldMessenger.of(context).showSnackBar(notif);
            }
            else if (status == ConnectivityStatus.disconnected) {
              SnackBar notif = FloatingSnackBar(
                  color: Colors.red,
                  message: "La connexion avec le serveur a échoué, veuillez réessayer"
              );
              ScaffoldMessenger.of(context).showSnackBar(notif);
            }
          })
        ],
          child: BlocBuilder<ConnectivityStatusCubit, ConnectivityStatus>(builder: (context, status) {
            if (status == ConnectivityStatus.loading) {
              return const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                        strokeWidth: 2.0,
                      )),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Initialisation serveur...',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          height: 20,
                          width: 20,
                          child: Container(
                              color: Colors.purple.shade300,
                              child: const Center(
                                child: Text(
                                    '_selectedOrganisation[0]',
                                    style: TextStyle(
                                      fontWeight:
                                      FontWeight.w500,
                                    )),
                              ))),
                      const Padding(
                        padding:
                        EdgeInsets.only(left: 8.0),
                        child: Text(
                          '_selectedOrganisation',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  const OrganisationMenuContext(),
                  const ServerMenuContext(),
                ],
              );
            }
          }),
        )
      ),
    );
  }
}
