import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:server_api/server_api.dart';
import 'package:user_api/user_api.dart';
import 'package:trust_app/accounting/logic/cubit/cubit.dart';

import 'package:trust_app/accounting/ui/page/activity_page.dart';
import 'package:trust_app/accounting/ui/page/billing_page.dart';
import 'package:trust_app/accounting/ui/page/dashboard_page.dart';
import 'package:trust_app/accounting/ui/page/journal_page.dart';
import 'package:trust_app/accounting/ui/page/payment_page.dart';
import 'package:trust_app/accounting/ui/page/third_party_page.dart';

class Accounting extends StatelessWidget {
  const Accounting({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {

    final server = context.read<ActiveServerCubit>().state;

    final List<Widget> pages = [
      AccountingDashboard(user: user),
      AccountingActivity(user: user),
      AccountingBilling(user: user),
      AccountingPayment(user: user),
      AccountingJournal(user: user),
      AccountingThirdParty(user: user)
    ];

    return BlocProvider(
      create: (context) => SwitchAccountingViewCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comptabilité'),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                tooltip: 'Configuration',
                icon: const Icon(Icons.settings),
                position: PopupMenuPosition.under,
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                        height: 5,
                        child: ListTile(title: Text('Dévise'),)
                    ),
                    const PopupMenuItem(
                        height: 5,
                        child: ListTile(title: Text('Exercice comptable'),)
                    ),
                    const PopupMenuItem(
                        height: 5,
                        child: ListTile(title: Text('Plan comptable'),)
                    ),
                  ];
                }
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
        body: Hero(
            tag: 'accounting-hero',
            child: BlocBuilder<SwitchAccountingViewCubit, int>(
                builder: (context, pageIndex) {
                  return Row(
                    children: [
                      NavigationRail(
                        destinations: const [
                          NavigationRailDestination(
                              icon: Icon(Icons.dashboard),
                              label: Text('Tableau de bord')
                          ),
                          NavigationRailDestination(
                              icon: Icon(FontAwesomeIcons.box),
                              label: Text('Activité')
                          ),
                          NavigationRailDestination(
                              icon: Icon(FontAwesomeIcons.receipt),
                              label: Text('Facturation')
                          ),
                          NavigationRailDestination(
                              icon: Icon(FontAwesomeIcons.cashRegister),
                              label: Text('Paiements')
                          ),
                          NavigationRailDestination(
                              icon: Icon(Icons.book),
                              label: Text('Journaux')
                          ),
                          NavigationRailDestination(
                              icon: Icon(Icons.groups),
                              label: Text('Tiers')
                          ),
                        ],
                        labelType: NavigationRailLabelType.all,
                        useIndicator: true,
                        selectedIndex: pageIndex,
                        onDestinationSelected: (index) {
                          context.read<SwitchAccountingViewCubit>().switchView(index);
                        },
                      ),
                      Expanded(
                          child: MultiBlocProvider(
                              providers: [
                                BlocProvider(create: (context) => FilterProductTypeCubit()),
                                BlocProvider(create: (context) => ActivityViewModeCubit()),
                                BlocProvider(create: (context) => FilterPartnerCategoryCubit()),
                                BlocProvider(create: (context) => ThirdPartyViewModeCubit()),
                              ],
                              child: Card(
                                color: Colors.white,
                                elevation: 5,
                                child: pages[pageIndex],
                              )
                          )
                      )
                    ],
                  );
                }
            )
        ),
        bottomNavigationBar: const BottomAppBar(color: Colors.black, height: 25,),
      ),
    );
  }
}
