import 'package:accounting_api/accounting_api.dart';
import 'package:activity_api/activity_api.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils/utils.dart';

import 'package:trust_app/home/ui/widget/widget.dart';

import 'package:trust_app/accounting/logic/cubit/cubit.dart';

class ProductInfoView extends StatelessWidget {
  ProductInfoView({super.key, this.product});

  final GlobalKey formKey = GlobalKey<FormState>();
  final Product? product;

  @override
  Widget build(BuildContext context) {

    return Form(
        key: formKey,
        child: Column(
          children: [
            LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth * 0.965,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black26)
                    ),
                    margin: const EdgeInsets.only(bottom: 25.0),
                    child: const CircleAvatar(),
                  );
                }
            ),
            const SizedBox(height: 10,),
            Expanded(
                flex: 1,
                child: BlocBuilder<ProductCategoryConfigCubit, List<Module>>(
                    builder: (_, modules) {
                      return GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        shrinkWrap: true,
                        childAspectRatio: 9.0,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  label: Text('Nom du produit*'),
                                  isDense: true,
                                  filled: true,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: MultiBlocListener(
                                listeners: [
                                  BlocListener<ProductCategoryApiStatusCubit, ApiStatus>(
                                    listener: (context, apiStatus) {
                                      SnackBar notif = FloatingSnackBar(
                                          color: Colors.red,
                                          message: "Impossible de récupérer les catégorie, un problème inattendu est survenu."
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(notif);
                                    },
                                    listenWhen: (previous, current) => current == ApiStatus.failed,
                                  ),
                                  BlocListener<ProductCategoryConfigApiStatusCubit, ApiStatus>(
                                    listener: (context, apiStatus) {
                                      SnackBar notif = FloatingSnackBar(
                                          color: Colors.red,
                                          message: "Impossible de récupérer la configuration de la catégorie, "
                                              "un problème inattendu est survenu."
                                      );

                                      ScaffoldMessenger.of(context).showSnackBar(notif);
                                    },
                                    listenWhen: (previous, current) => current == ApiStatus.failed,
                                  )
                                ],
                                child: BlocBuilder<ProductCategoryCubit, List<ProductCategory>>(
                                    builder: (context, productCategories) {
                                      return DropdownSearch<ProductCategory>(

                                        items: productCategories,
                                        itemAsString: (ProductCategory productCategory) => productCategory.name,
                                        validator: (value) {
                                          if(value == null) {
                                            return "Veuillez choisir la catégorie";
                                          }
                                          return null;
                                        },
                                        autoValidateMode: AutovalidateMode.onUserInteraction,
                                        onSaved: (value) {
                                          //context.read<SelectedCountryCubit>().change(value);
                                        },
                                        onChanged: (productCategory) {
                                          context.read<ProductCategoryConfigCubit>().getConfig(productCategory!.id);
                                        },
                                        dropdownDecoratorProps: const DropDownDecoratorProps(
                                            dropdownSearchDecoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              labelText: 'Catégorie*',
                                            )
                                        ),
                                        popupProps: PopupProps.menu(
                                            showSearchBox: true,
                                            searchFieldProps: const TextFieldProps(
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                    label: Text('Recherche ...'),
                                                    isDense: true,
                                                    filled: true
                                                )
                                            ),
                                            emptyBuilder: (context, text) {
                                              return const Center(
                                                child: SizedBox(
                                                  height: 50.0,
                                                  child: Text('Aucune catégorie trouvée'),
                                                ),
                                              );
                                            }
                                        ),
                                      );
                                    }
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Référence'),
                                isDense: true,
                                filled: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Code barre'),
                                isDense: true,
                                filled: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: DropdownSearch<String>(
                              items: const ['FC', 'USD'],
                              //itemAsString: (ProductCategory productCategory) => productCategory.name,
                              validator: (value) {
                                if(value == null) {
                                  return "Veuillez choisir la dévise";
                                }
                                return null;
                              },
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              onSaved: (value) {
                                //context.read<SelectedCountryCubit>().change(value);
                              },
                              onChanged: (currency) {
                                //context.read<ProductCategoryConfigCubit>().getConfig(productCategory!.id);
                              },
                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: "Dévise (lors de l'achat / de la vente) *",
                                  )
                              ),
                              popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  searchFieldProps: const TextFieldProps(
                                      autofocus: true,
                                      decoration: InputDecoration(
                                          label: Text('Recherche ...'),
                                          isDense: true,
                                          filled: true
                                      )
                                  ),
                                  emptyBuilder: (context, text) {
                                    return const Center(
                                      child: SizedBox(
                                        height: 50.0,
                                        child: Text('Aucune catégorie trouvée'),
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ),
                          ...List.generate(modules.length, (index) {
                            if (modules[index].name == 'achat') {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    label: Text("Prix d'achat"),
                                    isDense: true,
                                    filled: true,
                                  ),
                                ),
                              );
                            }
                            else if (modules[index].name == 'vente') {
                              return Padding(
                                padding: modules.any((module) => module.name == 'achat') ?
                                const EdgeInsets.only(left: 15.0) : const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    label: Text("Prix de vente"),
                                    isDense: true,
                                    filled: true,
                                  ),
                                ),
                              );
                            }
                            return const Text("Aucune configuration trouvée");
                          }),
                          if (modules.any((module) => module.name == 'vente'))
                            Padding(
                              padding: modules.any((module) => module.name == 'achat') ?
                              const EdgeInsets.symmetric(horizontal: 15.0) : const EdgeInsets.only(left: 15.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  label: Text("Prix de vente promotionnel"),
                                  isDense: true,
                                  filled: true,
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: BlocBuilder<SwitchPerishableCubit, bool>(
                                    builder: (_, isPerishable) {
                                      return SizedBox(
                                        width: 50,
                                        height: 30,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Switch(
                                              activeColor: Colors.blue.shade700,
                                              value: isPerishable,
                                              onChanged: (onChanged) {
                                                context.read<SwitchPerishableCubit>().change(onChanged);
                                              }
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ),
                              const Text('Périssable'),
                              const SizedBox(width: 20.0,),
                              if (modules.any((module) => module.name == 'vente'))
                                BlocBuilder<SwitchInPromoCubit, bool>(
                                    builder: (_, isPerishable) {
                                      return SizedBox(
                                        width: 50,
                                        height: 30,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Switch(
                                              activeColor: Colors.blue.shade700,
                                              value: isPerishable,
                                              onChanged: (onChanged) {
                                                context.read<SwitchInPromoCubit>().change(onChanged);
                                              }
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              if (modules.any((module) => module.name == 'vente'))
                                const Text('En promotion'),
                            ],
                          )
                        ],
                      );
                    }
                )
            )
          ],
        )
    );
  }
}


