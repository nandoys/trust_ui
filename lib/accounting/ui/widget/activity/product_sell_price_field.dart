import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:organization_api/organization_api.dart';
import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';

class ProductSellPriceField extends StatelessWidget {
  const ProductSellPriceField({super.key, required this.modules});

  final List<Module> modules;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveProductFormCubit, Map<String, dynamic>>(
        builder: (context, saveProduct) {
          return TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              label: Text("Prix de vente"),
              isDense: true,
              filled: true,
            ),
            validator: ValidationBuilder(localeName: 'fr', optional: true).regExp(
                RegExp(r'^[0-9]+\.?[0-9]*$'), "prix de vente invalide").add(
                    (value) {
                      final sellPrice = saveProduct['sell_price'] == null ? null : double.tryParse(saveProduct['sell_price']);

                      if (modules.any((module) => module.name == 'vente')) {
                        final buyPrice = saveProduct['buy_price'] == null ? null : double.tryParse(saveProduct['buy_price']);

                        if (buyPrice != null && sellPrice != null && buyPrice >= sellPrice) {
                          return "Le prix de vente doit supérieur au prix d'achat";
                        }
                      }
                      final currency = saveProduct['currency'] == null ? null : saveProduct['currency'] as Currency;
                      if (sellPrice != null && currency != null && currency.verify_unit(sellPrice) == false) {
                        return "Prix invalide pour la monnaie choisi";
                      }
                      return null;
                    }
            ).build(),
            onSaved: (value) {
              context.read<SaveProductFormCubit>().setValue('sell_price', value, modules);
            },
          );
        }
    );
  }
}
