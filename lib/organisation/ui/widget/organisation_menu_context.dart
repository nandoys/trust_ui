import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';
import 'package:organisation_api/organisation_api.dart';

import 'package:trust_app/organisation/logic/bloc/organisation/organisation_bloc.dart';
import 'package:trust_app/organisation/logic/bloc/server/server_bloc.dart';

class OrganisationMenuContext extends StatelessWidget {
  const OrganisationMenuContext({super.key});

  @override
  Widget build(BuildContext context) {
    final OrganisationRepository repository = context.read<OrganisationRepository>();
    print(context.read<ServerBloc>().state);

    return ContextMenuRegion(
        onDismissed: () => {},
        onItemSelected: (item) => {
          if (item.action == 'create') {
            //context.goNamed('organisation.signUp')
        context.read<OrganisationBloc>().add(OrganisationEvent(repository: repository))
          }
        },
        menuItems: [MenuItem(title: 'title', action: 'create')],
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
        ));
  }
}
