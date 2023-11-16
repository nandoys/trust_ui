import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user_api/user_api.dart';

class AccountingBilling extends StatelessWidget {
  AccountingBilling({super.key, required this.user});

  final User user;
  final billsViewController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Column(
              children: [
               Flexible(
                 flex: 1,
                   child:  Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
                     child: Row(
                       children: [
                         const Text(
                           "Factures",
                           style: TextStyle(
                               fontSize: 20.0,
                               fontWeight: FontWeight.w600
                           ),
                         ),
                         const Spacer(),
                         IconButton(
                             onPressed: (){},
                             icon: const Icon(Icons.add_circle)
                         ),
                         IconButton(
                             onPressed: (){},
                             icon: const Icon(Icons.filter_list)
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
                          FilterChip(label: const Text('payé'), onSelected: (bool value) {},),
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
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          FilterChip(label: const Text('Franc Congolais'), onSelected: (bool value) {},),
                          FilterChip(label: const Text('Dollar US'), onSelected: (bool value) {}),
                          FilterChip(label: const Text('Dollar CAD'), onSelected: (bool value) {}),
                          FilterChip(label: const Text('Euro'), onSelected: (bool value) {}),
                          FilterChip(label: const Text('Franc Suisse'), onSelected: (bool value) {}),
                        ],
                      ),
                    )
                ),
                Expanded(
                  flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Scrollbar(
                          controller: billsViewController,
                          thickness: 3.5,
                          thumbVisibility: true,
                          trackVisibility: true,
                          child: ListView(
                            controller: billsViewController,
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
        ),
        const Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('data')
              ],
            )
        ),
      ],
    );
  }
}
