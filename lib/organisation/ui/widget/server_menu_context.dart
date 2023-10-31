import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';
import 'package:trust_app/organisation/logic/cubit/server/connectivity/connectivity_status_cubit.dart';

import 'package:trust_app/organisation/logic/cubit/server/context_server/context_server_cubit.dart';

class ServerMenuContext extends StatelessWidget {
  const ServerMenuContext({super.key});

  @override
  Widget build(BuildContext context) {
    final contextServer = context.read<ContextServerCubit>();
    final statusServer = context.read<ConnectivityStatusCubit>();

    return ContextMenuRegion(
        onDismissed: () => {},
        onItemSelected: (item) {
          // if (item.action == 'create') {
          //   context.goNamed('server');
          // }
          //
          // if(item.title == 'Activer'){
          //   serveBloc.add(ServerAtivateEvent(current: item.action as String,));
          // }
          //
          // if(item.title == 'Modifier'){
          //   List<String> address = item.action.toString().split(':');
          //   context.goNamed(
          //       'server',
          //       queryParameters: {
          //         'host': address[0],
          //         'port': address[1]
          //       }
          //   );
          // }
          //
          // if(item.title == 'Supprimer'){
          //   serveBloc.add(
          //       ServerRemoveEvent(
          //           deleteServer: item.action as String
          //       )
          //   );
          // }

        },
        menuItems: [],
        child: TextButton.icon(
          onPressed: () {
            //serveBloc.add(ServerAtivateEvent(current: serveBloc.state.current,));

          },
          icon: const Icon(Icons.circle),
          label: Text(contextServer.state ?? 'Aucun',
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
                if (statusServer.state == ConnectivityStatus.connected) {
                  return Colors.green;
                } else {
                  return Colors.red;
                }
              }),
              overlayColor:
              MaterialStateProperty
                  .resolveWith((states) =>
              Colors
                  .grey.shade900)),
        ));
  }
}
