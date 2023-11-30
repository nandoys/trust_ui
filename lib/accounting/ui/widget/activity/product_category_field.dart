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
    return Padding(
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
                  onSaved: (category) {
                    context.read<SaveProductFormCubit>().setValue('product_category', category);
                  },
                  onChanged: (productCategory) {
                    context.read<ProductCategoryConfigCubit>().getConfig(
                        productCategory!.id, user.accessToken as String
                    );
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
    );
  }
}
