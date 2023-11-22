import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:user_api/user_api.dart';

import 'package:trust_app/accounting/ui/widget/accounting_widget.dart';

class AccountingPayment extends StatelessWidget {
  AccountingPayment({super.key, required this.user});

  final User user;
  final bankViewController = ScrollController();
  final cashViewController = ScrollController();
  final bankCurrencyController = ScrollController();
  final cashCurrencyController = ScrollController();

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
                          text: 'Banque',
                        ),
                        Tab(text: 'Caisse',),
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
                                            "Document bancaire",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: (){},
                                            icon: const Icon(Icons.add_circle),
                                            tooltip: "Nouveau document",
                                          ),
                                          PopupMenuButton(
                                            icon: const Icon(Icons.filter_list),
                                            tooltip: "Filtrer document",
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                    onTap: () {},
                                                    child: const Row(
                                                      children: [
                                                        // Flexible(
                                                        //     child: Icon(FontAwesomeIcons.moneyBill1)
                                                        // ),
                                                        // SizedBox(width: 10,),
                                                        Expanded(
                                                            child: Text('Entrant')
                                                        )
                                                      ],
                                                    )
                                                ),
                                                PopupMenuItem(
                                                    onTap: () {},
                                                    child: const Row(
                                                      children: [
                                                        // Flexible(
                                                        //     child: Icon(FontAwesomeIcons.moneyBill1)
                                                        // ),
                                                        // SizedBox(width: 10,),
                                                        Expanded(
                                                            child: Text('Sortant')
                                                        )
                                                      ],
                                                    )
                                                ),
                                              ];
                                            },
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
                                              label: const Text('Comptabilisé'),
                                              onSelected: (bool value) {},
                                            ),
                                            FilterChip(
                                                label: const Text('Brouillon'),
                                                onSelected: (bool value) {}
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                        child: Scrollbar(
                                            controller: bankCurrencyController,
                                            thumbVisibility: true,
                                            trackVisibility: true,
                                            thickness: 3.5,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              controller: bankCurrencyController,
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
                                            controller: bankViewController,
                                            thickness: 3.5,
                                            thumbVisibility: true,
                                            trackVisibility: true,
                                            child: ListView(
                                              controller: bankViewController,
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
                                            "Document de caisse",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: (){},
                                            icon: const Icon(Icons.add_circle),
                                            tooltip: "Nouveau document",
                                          ),
                                          PopupMenuButton(
                                            icon: const Icon(Icons.filter_list),
                                            tooltip: "Filtrer document",
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                    onTap: () {},
                                                    child: const Row(
                                                      children: [
                                                        // Flexible(
                                                        //     child: Icon(FontAwesomeIcons.moneyBill1)
                                                        // ),
                                                        // SizedBox(width: 10,),
                                                        Expanded(
                                                            child: Text('Entrant')
                                                        )
                                                      ],
                                                    )
                                                ),
                                                PopupMenuItem(
                                                    onTap: () {},
                                                    child: const Row(
                                                      children: [
                                                        // Flexible(
                                                        //     child: Icon(FontAwesomeIcons.moneyBill1)
                                                        // ),
                                                        // SizedBox(width: 10,),
                                                        Expanded(
                                                            child: Text('Sortant')
                                                        )
                                                      ],
                                                    )
                                                ),
                                              ];
                                            },
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
                                              label: const Text('Comptabilisé'),
                                              onSelected: (bool value) {},
                                            ),
                                            FilterChip(
                                                label: const Text('Brouillon'),
                                                onSelected: (bool value) {}
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                        child: Scrollbar(
                                            controller: cashCurrencyController,
                                            thumbVisibility: true,
                                            trackVisibility: true,
                                            thickness: 3.5,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              controller: cashCurrencyController,
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
                                            controller: cashViewController,
                                            thickness: 3.5,
                                            thumbVisibility: true,
                                            trackVisibility: true,
                                            child: ListView(
                                              controller: cashViewController,
                                              physics: const BouncingScrollPhysics(),
                                              children: List.generate(100, (index) {
                                                return Card(
                                                  child: ListTile(
                                                    selected: index == 4,
                                                    onTap: () {
                                                      print('Do something');
                                                    },
                                                    leading: CircleAvatar(backgroundColor: index == 4 ? Colors.green : Colors.blue,),
                                                    title: Text('sortie $index'),
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
            child: const Placeholder()
        ),
      ],
    );
  }
}
