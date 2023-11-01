import 'package:flutter/material.dart';
import 'package:native_context_menu/native_context_menu.dart';

class OrganisationMenuContext extends StatelessWidget {
  const OrganisationMenuContext({super.key});

  @override
  Widget build(BuildContext context) {

    return ContextMenuRegion(
        onDismissed: () => {},
        onItemSelected: (item) => {
          if (item.action == 'create') {
            //context.goNamed('organisation.signUp')
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
                fontSize: 14.0),
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
