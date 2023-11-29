import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:server_api/server_api.dart';
import 'package:user_api/user_api.dart';
import 'package:activity_api/activity_api.dart';

import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';
import 'package:trust_app/accounting/ui/widget/accounting_widget.dart';
import 'package:utils/utils.dart';

class AccountingActivity extends StatelessWidget {
  AccountingActivity({super.key, required this.user});

  final User user;
  final verticalScrollController = ScrollController();
  final horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    final server = context.read<ActiveServerCubit>().state;

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (context) => ProductCategoryRepository(
                  protocol: server.protocol, host: server.host, port: server.port
              )
          ),
          RepositoryProvider(
              create: (context) => ModuleRepository(
                  protocol: server.protocol, host: server.host, port: server.port
              )
          )
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => ProductCategoryApiStatusCubit()
              ),
              BlocProvider(
                  create: (context) => ProductCategoryConfigApiStatusCubit()
              ),
              BlocProvider(
                  create: (context) => ProductCategoryCubit(
                      productCategoryRepository: context.read<ProductCategoryRepository>(),
                      connectivityStatus: context.read<ConnectivityStatusCubit>(),
                      apiStatus: context.read<ProductCategoryApiStatusCubit>()
                  ),
              ),
              BlocProvider(
                create: (context) => ProductCategoryConfigCubit(
                    repository: context.read<ModuleRepository>(),
                    connectivityStatus: context.read<ConnectivityStatusCubit>(),
                    apiStatus: context.read<ProductCategoryConfigApiStatusCubit>()
                ),
              )
            ],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ActivityTitleWidget(),
                      ActivityNewButton(user: user,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: BlocBuilder<ActivityViewModeCubit, ViewMode>(
                      builder: (context, viewMode) {
                        return BlocBuilder<FilterProductTypeCubit, Set<ProductType>>(
                            builder: (context, filter) {
                              final productTypeCubit = context.read<FilterProductTypeCubit>();
                              return Row(
                                children: [
                                  FilterChip(
                                    label: Text(
                                        ProductType.bien.name.replaceFirst(
                                            ProductType.bien.name[0],
                                            ProductType.bien.name[0].toUpperCase()
                                        )
                                    ),
                                    selected: filter.contains(ProductType.bien),
                                    onSelected: (selected) {
                                      if(selected) {
                                        final Set<ProductType> filters = filter;
                                        filters.add(ProductType.bien);
                                        productTypeCubit.onSelectionChanged(filters.toSet());
                                      } else if (filter.length > 1) {
                                        final filters = filter;
                                        filters.remove(ProductType.bien);
                                        productTypeCubit.onSelectionChanged(filters.toSet());
                                      }
                                    },
                                  ),
                                  FilterChip(
                                      label: Text(
                                          ProductType.service.name.replaceFirst(
                                              ProductType.service.name[0],
                                              ProductType.service.name[0].toUpperCase()
                                          )
                                      ),
                                      selected: filter.contains(ProductType.service),
                                      onSelected: (selected) {
                                        if(selected) {
                                          final Set<ProductType> filters = filter;
                                          filters.add(ProductType.service);
                                          productTypeCubit.onSelectionChanged(filters.toSet());
                                        } else if (filter.length > 1) {
                                          final filters = filter;
                                          filters.remove(ProductType.service);
                                          productTypeCubit.onSelectionChanged(filters.toSet());
                                        }
                                      }
                                  ),
                                  FilterChip(
                                      label: Text(
                                          ProductType.mixte.name.replaceFirst(
                                              ProductType.mixte.name[0],
                                              ProductType.mixte.name[0].toUpperCase()
                                          )
                                      ),
                                      selected: filter.contains(ProductType.mixte),
                                      onSelected: (selected) {
                                        if(selected) {
                                          final Set<ProductType> filters = filter;
                                          filters.add(ProductType.mixte);
                                          productTypeCubit.onSelectionChanged(filters.toSet());
                                        } else if (filter.length > 1) {
                                          final filters = filter;
                                          filters.remove(ProductType.mixte);
                                          productTypeCubit.onSelectionChanged(filters.toSet());
                                        }
                                      }
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
                                      context.read<ActivityViewModeCubit>().changeView(ViewMode.table);
                                    },
                                    icon: const Icon(Icons.table_view),
                                    selectedIcon: const Icon(Icons.table_view, color: Colors.red,),
                                    isSelected: viewMode == ViewMode.table,
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      context.read<ActivityViewModeCubit>().changeView(ViewMode.grid);
                                    },
                                    icon: const Icon(Icons.grid_view),
                                    selectedIcon: const Icon(Icons.grid_view, color: Colors.red,),
                                    isSelected: viewMode == ViewMode.grid,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: IconButton(
                                      onPressed: (){
                                        context.read<ActivityViewModeCubit>().changeView(ViewMode.list);
                                      },
                                      icon: const Icon(Icons.list),
                                      selectedIcon: const Icon(Icons.list, color: Colors.red,),
                                      isSelected: viewMode == ViewMode.list,
                                    ),
                                  ),
                                ],
                              );
                            }
                        );
                      }
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BlocBuilder<ActivityViewModeCubit, ViewMode>(
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
                                                  label: const Text('Nom du produit'),
                                                  onSort: (index, selected) {},
                                                ),
                                                DataColumn(
                                                  label: const Text('Catégorie'),
                                                  onSort: (index, selected) {},
                                                ),
                                                DataColumn(
                                                  label: const Text('En promotion'),
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
                                                          child: Text('Jus de Fruit'),
                                                        ),
                                                        showEditIcon: true,
                                                        onTap: () { }
                                                    ),
                                                    const DataCell(
                                                        SizedBox(
                                                          width: 300,
                                                          child: Text('Marchandise'),
                                                        )
                                                    ),
                                                    const DataCell(
                                                      Chip(label: Text('Non'), backgroundColor: Colors.red,),
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
            )
        )
    );
  }

}
