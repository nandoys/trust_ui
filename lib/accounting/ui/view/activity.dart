import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_api/user_api.dart';

import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';

class AccountingActivity extends StatelessWidget {
  AccountingActivity({super.key, required this.user});

  final User user;
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => FilterProductCategoryCubit()),
          BlocProvider(create: (context) => ViewModeCubit()),
        ],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Vos produits',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add, color: Colors.white,),
                    onPressed: (){},
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
              child: BlocBuilder<ViewModeCubit, ViewMode>(
                  builder: (context, viewMode) {
                    return Row(
                      children: [
                        BlocBuilder<FilterProductCategoryCubit, Set<ProductCategory>>(
                            builder: (context, productCategoryFilter) {
                              return SegmentedButton<ProductCategory>(
                                segments: const [
                                  ButtonSegment<ProductCategory>(value:ProductCategory.bien, label: Text('Bien')),
                                  ButtonSegment<ProductCategory>(value:ProductCategory.service, label: Text('Service')),
                                  ButtonSegment<ProductCategory>(value:ProductCategory.mixte, label: Text('Mixte')),
                                ],
                                selected: productCategoryFilter,
                                multiSelectionEnabled: true,
                                onSelectionChanged: (Set<ProductCategory> selected){
                                  context.read<FilterProductCategoryCubit>().onSelectionChanged(selected);
                                },
                              );
                            }
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: (){
                            context.read<ViewModeCubit>().changeView(ViewMode.grid);
                          },
                          icon: const Icon(Icons.grid_view),
                          selectedIcon: const Icon(Icons.grid_view, color: Colors.red,),
                          isSelected: viewMode == ViewMode.grid,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: IconButton(
                            onPressed: (){
                              context.read<ViewModeCubit>().changeView(ViewMode.list);
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
            Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Scrollbar(
                    controller: scrollController,
                    trackVisibility: true,
                    thumbVisibility: true,
                      child: BlocBuilder<ViewModeCubit, ViewMode>(
                          builder: (context, viewMode) {
                            return GridView.count(
                              crossAxisCount: 4,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 4,
                              childAspectRatio: viewMode == ViewMode.list ? 4.5 : 1.5,
                              shrinkWrap: true,
                              controller: scrollController,
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
                            );
                          }
                      )
                  ),
                )
            )
          ],
        )
    );
  }
}
