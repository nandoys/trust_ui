import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user_api/user_api.dart';

import 'package:trust_app/accounting/ui/widget/accounting_widget.dart';

class AccountingBilling extends StatelessWidget {
  AccountingBilling({super.key, required this.user});

  final User user;
  final customerBillsViewController = ScrollController();
  final supplierBillsViewController = ScrollController();
  final customerCurrencyController = ScrollController();
  final supplierCurrencyController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
            flex: 1,
            child: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(
                          text: 'Client',
                        ),
                        Tab(text: 'Fournisseur',),
                      ],
                    ),
                    Expanded(
                        child: TabBarView(
                            children: [
                              Column(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child:  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Factures clients",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: (){},
                                            icon: const Icon(Icons.add_circle),
                                            tooltip: "Nouvelle facture",
                                          ),
                                          IconButton(
                                            onPressed: (){},
                                            icon: const Icon(Icons.filter_list),
                                            tooltip: "Filtrer facture",
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              label: Text('Recherche...'),
                                              isDense: true,
                                              filled: true
                                          ),
                                        ),
                                      )
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                        child: Row(
                                          children: [
                                            FilterChip(
                                              label: const Text('payé'),
                                              onSelected: (bool value) {},
                                            ),
                                            FilterChip(label: const Text('impayé'), onSelected: (bool value) {}),
                                            FilterChip(label: const Text('en retard'), onSelected: (bool value) {}),
                                          ],
                                        ),
                                      )
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                        child: Scrollbar(
                                            controller: customerCurrencyController,
                                            thumbVisibility: true,
                                            trackVisibility: true,
                                            thickness: 3.5,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              controller: customerCurrencyController,
                                              children: [
                                                FilterChip(label: const Text('Franc Congolais'), onSelected: (bool value) {},),
                                                FilterChip(label: const Text('Dollar US'), onSelected: (bool value) {}),
                                                FilterChip(label: const Text('Dollar CAD'), onSelected: (bool value) {}),
                                                FilterChip(label: const Text('Euro'), onSelected: (bool value) {}),
                                                FilterChip(label: const Text('Franc Suisse'), onSelected: (bool value) {}),
                                              ],
                                            )
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                        child: Scrollbar(
                                            controller: customerBillsViewController,
                                            thickness: 3.5,
                                            thumbVisibility: true,
                                            trackVisibility: true,
                                            child: ListView(
                                              controller: customerBillsViewController,
                                              physics: const BouncingScrollPhysics(),
                                              children: List.generate(100, (index) {
                                                return Card(
                                                  child: ListTile(
                                                    selected: index == 4,
                                                    onTap: () {
                                                      print('Do something');
                                                    },
                                                    leading: CircleAvatar(backgroundColor: index == 4 ? Colors.green : Colors.blue,),
                                                    title: Text('facture $index'),
                                                    subtitle: const Row(
                                                      children: [
                                                        Flexible(child: Text('paiement state')),
                                                        Spacer(),
                                                        Flexible(child: Text('data'))
                                                      ],
                                                    ),
                                                    trailing: Text(DateFormat('d-M-yyy').format(DateTime.now())),
                                                  ),
                                                );
                                              }),
                                            )
                                        ),
                                      )
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child:  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Factures fournisseurs",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: (){},
                                            icon: const Icon(Icons.add_circle),
                                            tooltip: "Nouvelle facture",
                                          ),
                                          IconButton(
                                            onPressed: (){},
                                            icon: const Icon(Icons.filter_list),
                                            tooltip: "Filtrer facture",
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              label: Text('Recherche...'),
                                              isDense: true,
                                              filled: true
                                          ),
                                        ),
                                      )
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                        child: Row(
                                          children: [
                                            FilterChip(
                                              label: const Text('payé'),
                                              onSelected: (bool value) {},
                                            ),
                                            FilterChip(label: const Text('impayé'), onSelected: (bool value) {}),
                                            FilterChip(label: const Text('en retard'), onSelected: (bool value) {}),
                                          ],
                                        ),
                                      )
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                        child: Scrollbar(
                                            controller: supplierCurrencyController,
                                            thumbVisibility: true,
                                            trackVisibility: true,
                                            thickness: 3.5,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              controller: supplierCurrencyController,
                                              children: [
                                                FilterChip(label: const Text('Franc Congolais'), onSelected: (bool value) {},),
                                                FilterChip(label: const Text('Dollar US'), onSelected: (bool value) {}),
                                                FilterChip(label: const Text('Dollar CAD'), onSelected: (bool value) {}),
                                                FilterChip(label: const Text('Euro'), onSelected: (bool value) {}),
                                                FilterChip(label: const Text('Franc Suisse'), onSelected: (bool value) {}),
                                              ],
                                            )
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                        child: Scrollbar(
                                            controller: supplierBillsViewController,
                                            thickness: 3.5,
                                            thumbVisibility: true,
                                            trackVisibility: true,
                                            child: ListView(
                                              controller: supplierBillsViewController,
                                              physics: const BouncingScrollPhysics(),
                                              children: List.generate(100, (index) {
                                                return Card(
                                                  child: ListTile(
                                                    selected: index == 4,
                                                    onTap: () {
                                                      print('Do something');
                                                    },
                                                    leading: CircleAvatar(backgroundColor: index == 4 ? Colors.green : Colors.blue,),
                                                    title: Text('facture $index'),
                                                    subtitle: const Row(
                                                      children: [
                                                        Flexible(child: Text('paiement state')),
                                                        Spacer(),
                                                        Flexible(child: Text('data'))
                                                      ],
                                                    ),
                                                    trailing: Text(DateFormat('d-M-yyy').format(DateTime.now())),
                                                  ),
                                                );
                                              }),
                                            )
                                        ),
                                      )
                                  )
                                ],
                              )
                            ]
                        )
                    )
                  ],
                )
            )
        ),
        Expanded(
            flex: width < 1400 ? 2 : 3,
            child: const BillWidget()
        ),
      ],
    );
  }
}
