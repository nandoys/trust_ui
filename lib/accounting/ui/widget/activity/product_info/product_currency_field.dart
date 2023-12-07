import 'package:activity_api/activity_api.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organization_api/organization_api.dart';
import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';
import 'package:user_api/user_api.dart';

class ProductCurrencyField extends StatelessWidget {
  const ProductCurrencyField({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final currencyCubit = context.read<CurrencyCubit>();
    final organizationCurrencyCubit = context.read<OrganizationCurrencyCubit>();

    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: BlocBuilder<OrganizationCurrencyCubit, List<Currency>>(
          builder: (context, organizationCurrencies) {
            return BlocBuilder<EditingProductCubit, Product?>(
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
                          filled: true,
                          labelText: "Dévise (lors de l'achat / de la vente) *",
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
                            maxHeight: 200
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
                                  const Text('Aucune dévise trouvée'),
                                  if (organizationCurrencies.isEmpty) TextButton.icon(
                                      onPressed: () {
                                        if(currencyCubit.state.isEmpty) {
                                          currencyCubit.getCurrencies(user.accessToken as String);
                                        }

                                        if(organizationCurrencyCubit.state.isEmpty) {
                                          organizationCurrencyCubit.getCurrencies(
                                              user.organization,
                                              user.accessToken as String
                                          );
                                        }

                                      },
                                      icon: const Icon(Icons.refresh),
                                      label: const Text('Rafraîchir')
                                  )
                                ],
                              ),
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
