import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/organisation/logic/cubit/server/connectivity/connectivity_status_cubit.dart';
import 'package:trust_app/organisation/logic/cubit/server/context_server/context_server_cubit.dart';
import 'package:trust_app/organisation/logic/cubit/server/context_menu/context_menu_cubit.dart';

class ServerMenuContext extends StatelessWidget {
  const ServerMenuContext({super.key});

  @override
  Widget build(BuildContext context) {
    final contextServerCubit = context.read<ContextServerCubit>();
    final menuServerCubit = context.read<ServerContextMenuCubit>();

    return BlocBuilder<ServerContextMenuCubit, List<MenuItem>>(builder: (context, menus) {
      return ContextMenuRegion(
          onDismissed: () => {},
          onItemSelected: (item) {
            if (item.action == 'create http') {
              context.pushNamed('server', queryParameters: {'protocol': 'http'});
            }

            if (item.action == 'create https') {
              context.pushNamed('server', queryParameters: {'protocol': 'https'});
            }

            if(item.title == 'Activer'){
              menuServerCubit.activateServer(item.action as String);
            }

            if(item.title == 'Modifier'){
              List<String> address = item.action.toString().split(':');
              context.goNamed(
                  'server',
                  queryParameters: {
                    'host': address[0],
                    'port': address[1]
                  }
              );
            }

            if(item.title == 'Supprimer'){
              menuServerCubit.removeServer(item.action as String);
            }
          },
          menuItems: menus,
          child: TextButton.icon(
            onPressed: () {
              if (contextServerCubit.state != null) {
                menuServerCubit.activateServer(contextServerCubit.state as String);
              }
            },
            icon: BlocBuilder<ConnectivityStatusCubit, ConnectivityStatus>(builder: (context, status) {
              if (status == ConnectivityStatus.connected) {
                return const Icon(Icons.circle, color: Colors.green,);
              }
              else if (status == ConnectivityStatus.disconnected) {
                return const Icon(Icons.circle, color: Colors.red,);
              }
              return const Icon(Icons.circle, color: Colors.blue,);
            }),
            label: BlocBuilder<ContextServerCubit, String?>(builder: (context, currentServer) {
              return Text(currentServer ?? 'Aucun serveur',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0),
              );
            }),
            style: ButtonStyle(
                iconSize: MaterialStateProperty.resolveWith((states) => 15.0),
                overlayColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade900)),
          ));
    });
  }
}
