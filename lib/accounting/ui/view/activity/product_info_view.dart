import 'package:activity_api/activity_api.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils/utils.dart';

import 'package:trust_app/home/ui/widget/widget.dart';

class ProductInfoView extends StatelessWidget {
  const ProductInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Nom du produit'),
                        isDense: true,
                        filled: true,
                      ),
                    ),
                  )
              ),
              Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: BlocListener<ProductCategoryApiStatusCubit, ApiStatus>(
                      listener: (context, apiStatus) {
                        SnackBar notif = FloatingSnackBar(
                            color: Colors.red,
                            message: "Impossible de récupérer les catégorie, un problème inattendu "
                                "est survenu du côté serveur."
                        );
                        ScaffoldMessenger.of(context).showSnackBar(notif);
                      },
                      listenWhen: (previous, current) => current == ApiStatus.failed,
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
                      ),
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
