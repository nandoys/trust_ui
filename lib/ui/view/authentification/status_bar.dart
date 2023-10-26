import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/logic/bloc/server/server_bloc.dart';

import 'package:trust_app/ui/page/server/server_page.dart';
import 'package:trust_app/ui/widget/server/floating_snack_bar.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({super.key});

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  List<MenuItem> serverMenu = [MenuItem(title: 'Nouveau', action: 'create')];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServerBloc, ServerState>(
      listener: (context, state) {

        if (state.status == ServerStatus.failure) {
          SnackBar notif = FloatingSnackBar(
              color: Colors.red,
              message: "La connexion avec le serveur a échoué, veuillez réessayer"
          );
          ScaffoldMessenger.of(context).showSnackBar(notif);
        }

        if (state.status == ServerStatus.success) {
          SnackBar notif = FloatingSnackBar(
              color: Colors.green,
              message: "La connexion avec le serveur établie avec succès"
          );

          ScaffoldMessenger.of(context).showSnackBar(notif);
        }
      },
      child: BlocBuilder<ServerBloc, ServerState>(
        builder: (context, state) {
          print(state);
          return SizedBox(
            height: 27,
            child: Container(
              color: Colors.black,
              child: state.status != ServerStatus.initial
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  state.status == ServerStatus.success
                      ? Row(
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
                  )
                      : const Divider(),
                  state.status == ServerStatus.success
                      ? ContextMenuRegion(
                      onDismissed: () => {},
                      onItemSelected: (item) => {},
                      menuItems: [],
                      child: TextButton.icon(
                        onPressed: () {
                          print('object');
                        },
                        icon: const Icon(Icons.circle),
                        label: const Text(
                          'organisation',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0),
                        ),
                        style: ButtonStyle(
                            iconSize: MaterialStateProperty
                                .resolveWith((states) => 15.0),
                            iconColor: MaterialStateProperty
                                .resolveWith(
                                    (states) => Colors.blue),
                            overlayColor: MaterialStateProperty
                                .resolveWith((states) =>
                            Colors.grey.shade900)),
                      ))
                      : const Divider(
                    thickness: 0.1,
                  ),
                  ContextMenuRegion(
                      onDismissed: () => {},
                      onItemSelected: (item) {
                        if (item.action == 'create') {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) =>
                                      BlocProvider.value(
                                        value: context.read<ServerBloc>(),
                                        child: const ServerPage(),
                                      )
                              )
                          );
                        }

                        if(item.title == 'Activer'){

                          context.read<ServerBloc>().add(
                              ServerAtivateEvent(current: item.action as String,)
                          );
                        }

                        if(item.title == 'Modifier'){
                          List<String> address = item.action.toString().split(':');

                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) =>
                                      BlocProvider.value(
                                        value: context.read<ServerBloc>(),
                                        child: ServerPage(host: address[0], port: address[1],),
                                      )
                              )
                          );
                        }

                        if(item.title == 'Supprimer'){
                          context.read<ServerBloc>().add(
                              ServerRemoveEvent(
                                  deleteServer: item.action as String
                              )
                          );
                        }

                      },
                      menuItems: state.contextMenu as List<MenuItem>,
                      child: TextButton.icon(
                        onPressed: () {
                          print('seveur bouton');
                        },
                        icon: const Icon(Icons.circle),
                        label: Text(
                          state.current != null ? state.current as String : 'Aucun Serveur',
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
                              if (state.status == ServerStatus.success && state.current != null) {
                                return Colors.green;
                              } else if (state.status == ServerStatus.failure) {
                                return Colors.red;
                              }

                              return Colors.blue;
                            }),
                            overlayColor:
                            MaterialStateProperty
                                .resolveWith((states) =>
                            Colors
                                .grey.shade900)),
                      )),
                ],
              )
                  : const Row(
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
              ),
            ),
          );
        },
      ),
    );
  }
}
