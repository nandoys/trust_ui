import 'package:activity_api/activity_api.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trust_app/home/ui/widget/widget.dart';
import 'package:user_api/user_api.dart';
import 'package:utils/utils.dart';

import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';

class ProductCategoryField extends StatelessWidget {
  const ProductCategoryField({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final productCategoryCubit = context.read<ProductCategoryCubit>();

    return BlocProvider(
      create: (context) => OnchangeProductCategoryCubit(),
      child: Padding(
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
            ],
            child: BlocBuilder<ProductCategoryCubit, List<ProductCategory>>(
                builder: (context, productCategories) {
                  return BlocBuilder<OnchangeProductCategoryCubit, ProductCategory?>(
                      builder: (context, onChangeProductCategory) {
                        return BlocBuilder<EditingProductCubit, Product?>(
                            builder: (context, editProduct) {

                              // select the module in case of editing an existing product
                              if (editProduct?.productCategory != null && onChangeProductCategory == null) {
                                context.read<ProductCategoryConfigCubit>().selectModule(editProduct!.productCategory.modules);
                              }

                              // reset the onchangeProductCategory for new product
                              else if (editProduct?.productCategory == null) {
                                context.read<OnchangeProductCategoryCubit>().change(null);
                              }

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
                                selectedItem: editProduct?.productCategory,
                                onSaved: (category) {
                                  context.read<SaveProductFormCubit>().setValue('product_category', category);
                                },
                                onChanged: (productCategory) {
                                  if (productCategory != editProduct?.productCategory) {
                                    context.read<ProductCategoryConfigCubit>().selectModule(productCategory!.modules);
                                    context.read<OnchangeProductCategoryCubit>().change(productCategory);
                                  }
                                },
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      filled: true,
                                      labelText: 'Catégorie*',
                                    )
                                ),
                                popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  searchDelay: const Duration(milliseconds: 0),
                                  searchFieldProps: const TextFieldProps(
                                      autofocus: true,
                                      decoration: InputDecoration(
                                          label: Text('Rechercher'),
                                          prefixIcon: Icon(Icons.search),
                                          isDense: true,
                                          filled: true
                                      )
                                  ),
                                  constraints: const BoxConstraints(
                                      maxHeight: 200,
                                  ),
                                  scrollbarProps: const ScrollbarProps(
                                      thumbVisibility: true,
                                      trackVisibility: true,
                                  ),
                                  emptyBuilder: (context, text) {
                                    return Center(
                                      child: SizedBox(
                                        height: 80.0,
                                        child: Column(
                                          children: [
                                            const Text('Aucune catégorie trouvée'),
                                            if (productCategoryCubit.state.isEmpty) TextButton.icon(
                                                onPressed: () {
                                                  productCategoryCubit.getCategories(user.accessToken as String);
                                                },
                                                icon: const Icon(Icons.refresh),
                                                label: const Text('Rafraîchir')
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                        );
                      }
                  );
                }
            )
        ),
      ),
    );
  }
}
