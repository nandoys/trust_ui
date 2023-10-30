import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/organisation/logic/bloc/server/server_bloc.dart';

class ServerMenuContext extends StatelessWidget {
  const ServerMenuContext({super.key});

  @override
  Widget build(BuildContext context) {
    final serveBloc = context.read<ServerBloc>();

    return ContextMenuRegion(
        onDismissed: () => {},
        onItemSelected: (item) {
          if (item.action == 'create') {
            context.goNamed('server');
          }

          if(item.title == 'Activer'){
            serveBloc.add(ServerAtivateEvent(current: item.action as String,));
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
            serveBloc.add(
                ServerRemoveEvent(
                    deleteServer: item.action as String
                )
            );
          }

        },
        menuItems: serveBloc.state.contextMenu as List<MenuItem>,
        child: TextButton.icon(
          onPressed: () {
            serveBloc.add(ServerAtivateEvent(current: serveBloc.state.current,));
          },
          icon: const Icon(Icons.circle),
          label: Text(
            serveBloc.state.current != null ? serveBloc.state.current as String : 'Aucun Serveur',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0),
          ),
          style: ButtonStyle(
              iconSize: MaterialStateProperty
                  .resolveWith(
                      (states) => 15.0),
              iconColor: MaterialStateProperty
                  .resolveWith((states) {
                if (serveBloc.state.status == ServerStatus.success && serveBloc.state.current != null) {
                  return Colors.green;
                } else if (serveBloc.state.status == ServerStatus.failure) {
                  return Colors.red;
                }

                return Colors.blue;
              }),
              overlayColor:
              MaterialStateProperty
                  .resolveWith((states) =>
              Colors
                  .grey.shade900)),
        ));
  }
}
