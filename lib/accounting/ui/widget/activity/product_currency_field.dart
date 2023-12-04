import 'package:activity_api/activity_api.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organization_api/organization_api.dart';
import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';

class ProductCurrencyField extends StatelessWidget {
  const ProductCurrencyField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: BlocBuilder<OrganizationCurrencyCubit, List<Currency>>(
          builder: (context, organizationCurrencies) {
            return BlocBuilder<EditingProduct, Product?>(
                builder: (context, editProduct) {
                  return DropdownSearch<Currency>(
                    items: organizationCurrencies,
                    itemAsString: (Currency currency) => currency.name,
                    validator: (value) {
                      if(value == null) {
                        return "Veuillez choisir la dévise";
                      }
                      return null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    selectedItem: editProduct?.currency,
                    onSaved: (currency) {
                      context.read<SaveProductFormCubit>().setValue('currency', currency);
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
                  );
                }
            );
          }
      ),
    );
  }
}
