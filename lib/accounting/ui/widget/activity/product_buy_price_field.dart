import 'package:accounting_api/accounting_api.dart';
import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:organization_api/organization_api.dart';
import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';

class ProductBuyPriceField extends StatelessWidget {
  const ProductBuyPriceField({super.key, required this.modules, required this.controller});

  final List<Module> modules;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: BlocBuilder<SaveProductFormCubit, Map<String, dynamic>>(
          builder: (context, saveProduct) {
            return BlocBuilder<EditingProduct, Product?>(
                builder: (context, editProduct) {
                  return TextFormField(
                    controller: controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      label: Text("Prix d'achat"),
                      isDense: true,
                      filled: true,
                    ),
                    validator: ValidationBuilder(localeName: 'fr', optional: true).regExp(
                        RegExp(r'^[0-9]+\.?[0-9]*$'), "prix d'achat invalide").add(
                            (value) {
                          final buyPrice = saveProduct['buying_price'] == null ? null :
                          double.tryParse(saveProduct['buying_price']);

                          final currency = saveProduct['currency'] == null ? null : saveProduct['currency'] as Currency;
                          if (buyPrice != null && currency != null && currency.verify_unit(buyPrice) == false) {
                            return "Prix invalide pour la monnaie choisi";
                          }

                          return null;
                        }
                    ).build(),
                    onSaved: (value) {
                      context.read<SaveProductFormCubit>().setValue('buying_price', value, modules);
                    },
                  );
                }
            );
          }
      ),
    );
  }
}
