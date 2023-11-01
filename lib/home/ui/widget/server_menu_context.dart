import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/home/logic/cubit/cubit.dart';

import 'package:trust_app/utils.dart';

class ServerMenuContext extends StatelessWidget {
  const ServerMenuContext({super.key});

  @override
  Widget build(BuildContext context) {
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
              final serverPart = item.action.toString().split(' ');
              final protocol = getProtocol(item.action.toString());
              List<String> address = serverPart[1].split(':');
              context.goNamed(
                  'server',
                  queryParameters: { 'host': address[0], 'port': address[1], 'protocol': protocol}
              );
            }

            if(item.title == 'Supprimer'){
              menuServerCubit.removeServer(item.action as String);
            }
          },
          menuItems: menus,
          child: BlocBuilder<ActiveServerCubit, ActiveServerState>(builder: (context, activeServer) {
            return TextButton.icon(
              onPressed: () {
                activeServer is ActiveServerSelected ?
                menuServerCubit.activateServer(activeServer.fullAddress as String) : null;
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
              label: Text(activeServer.fullAddress ?? 'Aucun serveur',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0),
              ),
              style: ButtonStyle(
                  iconSize: MaterialStateProperty.resolveWith((states) => 15.0),
                  overlayColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade900)),
            );
          }));
    });
  }
}
