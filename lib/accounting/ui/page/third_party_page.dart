import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_api/user_api.dart';

import 'package:trust_app/accounting/logic/cubit/third_party/third_party_cubit.dart';
import 'package:utils/utils.dart';

class AccountingThirdParty extends StatelessWidget {
  AccountingThirdParty({super.key, required this.user});

  final User user;
  final verticalScrollController = ScrollController();
  final horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Vos partenaires',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add, color: Colors.white,),
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Dialog(
                          child: SizedBox(
                            width: 850,
                            height: 600,
                            child: Column(
                              children: [Text('data')],
                            ),
                          ),
                        );
                      }
                  );
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue.shade700),
                    fixedSize: MaterialStateProperty.resolveWith((states) => const Size.fromHeight(5))
                ),
                label: const Text('Nouveau', style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: BlocBuilder<ThirdPartyViewModeCubit, ViewMode>(
              builder: (context, viewMode) {
                return Row(
                  children: [
                    ChoiceChip(
                        label: const Text('Client'),
                        selected: true,
                        onSelected: (selected) {}
                    ),
                    ChoiceChip(
                        label: const Text('Fournisseur'),
                        selected: true,
                        onSelected: (selected) {}
                    ),
                    const Spacer(),
                    const SizedBox(
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                            label: Text("Recherche"),
                            isDense: true,
                            contentPadding: EdgeInsets.all(2)
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        context.read<ThirdPartyViewModeCubit>().changeView(ViewMode.table);
                      },
                      icon: const Icon(Icons.table_view),
                      selectedIcon: const Icon(Icons.table_view, color: Colors.red,),
                      isSelected: viewMode == ViewMode.table,
                    ),
                    IconButton(
                      onPressed: (){
                        context.read<ThirdPartyViewModeCubit>().changeView(ViewMode.grid);
                      },
                      icon: const Icon(Icons.grid_view),
                      selectedIcon: const Icon(Icons.grid_view, color: Colors.red,),
                      isSelected: viewMode == ViewMode.grid,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: IconButton(
                        onPressed: (){
                          context.read<ThirdPartyViewModeCubit>().changeView(ViewMode.list);
                        },
                        icon: const Icon(Icons.list),
                        selectedIcon: const Icon(Icons.list, color: Colors.red,),
                        isSelected: viewMode == ViewMode.list,
                      ),
                    ),
                  ],
                );
              }
          ),
        ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<ThirdPartyViewModeCubit, ViewMode>(
                  builder: (context, viewMode) {
                    if (viewMode == ViewMode.table) {
                      return Scrollbar(
                          controller: horizontalScrollController,
                          trackVisibility: true,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: horizontalScrollController,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Scrollbar(
                                controller: verticalScrollController,
                                trackVisibility: true,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  controller: verticalScrollController,
                                  physics: const BouncingScrollPhysics(),
                                  child: DataTable(
                                      columns: [
                                        DataColumn(
                                          label: const Text('Nom du partenaire'),
                                          onSort: (index, selected) {},
                                        ),
                                        DataColumn(
                                          label: const Text('Catégorie'),
                                          onSort: (index, selected) {},
                                        ),
                                        DataColumn(
                                          label: const Text('Email'),
                                          onSort: (index, selected) {},
                                        ),
                                        DataColumn(
                                          label: const Text('Téléphone'),
                                          onSort: (index, selected) {},
                                        ),
                                        DataColumn(
                                          label: const Text('Pays'),
                                          onSort: (index, selected) {},
                                        ),
                                      ],
                                      rows: List.generate(50, (index) {
                                        return DataRow(
                                          onSelectChanged: (isSelected) {
                                            print('selected ? $isSelected');
                                          },
                                          cells: [
                                            DataCell(
                                                const SizedBox(
                                                  width: 300,
                                                  child: Text('Gradi'),
                                                ),
                                                showEditIcon: true,
                                                onTap: () { }
                                            ),
                                            const DataCell(
                                                SizedBox(
                                                  child: Text('Particulier'),
                                                )
                                            ),
                                            const DataCell(
                                              Text('grnandoy@gmail.com'),
                                            ),
                                            const DataCell(
                                              Text('+243816886922'),
                                            ),
                                            const DataCell(
                                              Text('Rep. Dem. Congo'),
                                            ),
                                          ],
                                        );
                                      })
                                  ),
                                )
                            ),
                          )
                      );
                    }
                    return Scrollbar(
                        controller: verticalScrollController,
                        trackVisibility: true,
                        thumbVisibility: true,
                        child: GridView.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 4,
                          childAspectRatio: viewMode == ViewMode.list ? 4.2 : 1.5,
                          shrinkWrap: true,
                          controller: verticalScrollController,
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(50, (index) {
                            return Card(
                              child: viewMode == ViewMode.list ? ListTile(
                                leading: const CircleAvatar(backgroundColor: Colors.blue),
                                title: Text('$index data'),
                                subtitle: const Text('data'),
                                trailing: PopupMenuButton<String>(
                                    icon: const Icon(Icons.more_horiz),
                                    itemBuilder: (context) {
                                      return [
                                        const PopupMenuItem(child: Text('Modifier')),
                                        const PopupMenuItem(child: Text('Supprimer')),
                                        const PopupMenuDivider(),
                                        const PopupMenuItem(child: Text('Comptabilité')),
                                      ];
                                    }
                                ),
                              ) :
                              const Column(
                                children: [Text('data')],
                              ),
                            );
                          }),
                        )
                    );
                  }
              ),
            )
        )
      ],
    );
  }
}
