import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/home/ui/widget/widget.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

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
      height: 30,
      child: Container(
        color: Colors.black,
        child: MultiBlocListener(listeners: [
          BlocListener<ActiveServerCubit, ActiveServerState>(listener: (context, currentServer) {

          }),
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
          }),
          BlocListener<ServerContextMenuCubit, List<MenuItem>>(listener: (context, menus) {

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
              return const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OrganisationContextMenu(),
                  ServerMenuContext(),
                ],
              );
            }
          }),
        )
      ),
    );
  }
}
