import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';
import 'package:organisation_api/organisation_api.dart';

import 'package:trust_app/organisation/logic/bloc/server/server_bloc.dart';
import 'package:trust_app/organisation/ui/widget/floating_snack_bar.dart';

import 'package:trust_app/organisation/ui/widget/organisation_menu_context.dart';

import 'package:trust_app/organisation/ui/widget/server_menu_context.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({super.key});

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  List<MenuItem> serverMenu = [MenuItem(title: 'Nouveau', action: 'create')];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServerBloc, ServerState>(
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
        listenWhen: (prev, next) {
          return prev.status != next.status;
        },
        builder: (context, state) {
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
                      ? RepositoryProvider(
                    create: (context) => OrganisationRepository(host: state.current as String, protocol: 'http'),
                    child: const OrganisationMenuContext(),
                  )
                      : const Divider(
                    thickness: 0.1,
                  ),
                  const ServerMenuContext(),
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
        }
        );
  }
}
