import 'package:flutter/material.dart';
import 'package:user_api/user_api.dart';

class AccountingDashboard extends StatelessWidget {
  const AccountingDashboard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comptabilité'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
            tooltip: 'Configuration',
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.apps),
              tooltip: 'Mes applications',
          ),
          Tooltip(
            message: "Compte utilisateur",
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade700,
              maxRadius: 15,
              child: Text(user.username.toUpperCase().substring(0, 1)),
            ),
          ),
          const SizedBox(width: 20,)
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.dashboard),
                    label: Text('Tableau de bord')
                ),
                NavigationRailDestination(
                    icon: Icon(Icons.call_missed_outgoing_rounded),
                    label: Text('Activité')
                ),
                NavigationRailDestination(
                    icon: Icon(Icons.dashboard),
                    label: Text('Facturation')
                ),
                NavigationRailDestination(
                    icon: Icon(Icons.wallet),
                    label: Text('Trésorerie')
                ),
                NavigationRailDestination(
                    icon: Icon(Icons.book),
                    label: Text('Op. diverses')
                ),
                NavigationRailDestination(
                    icon: Icon(Icons.groups),
                    label: Text('Tiers')
                ),
              ],
              labelType: NavigationRailLabelType.all,
              useIndicator: true,
              selectedIndex: 0
          ),
          const Expanded(
              child: Card(
                color: Colors.white,
                elevation: 5,
                child: Center(
                  child: Text('Accounting page'),
                ),
              )
          )
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.black,
        height: 28
      ),
    );
  }
}
