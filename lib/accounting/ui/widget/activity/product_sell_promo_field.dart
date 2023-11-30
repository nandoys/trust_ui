import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:organization_api/organization_api.dart';
import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';

class ProductSellPromoField extends StatelessWidget {
  const ProductSellPromoField({super.key, required this.modules});

  final List<Module> modules;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveProductFormCubit, Map<String, dynamic>>(
        builder: (context, saveProduct) {
          return TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              label: Text("Prix de vente promotionnel"),
              isDense: true,
              filled: true,
            ),
            validator: ValidationBuilder(localeName: 'fr', optional: true).regExp(
                RegExp(r'^[0-9]+\.?[0-9]*$'), "prix de vente invalide").add(
                    (value) {
                  final sellPrice = saveProduct['sell_price'] == null ? null : double.tryParse(saveProduct['sell_price']);
                  final sellPromo = saveProduct['sell_in_promo'] == null ? null : double.tryParse(saveProduct['sell_in_promo']);
                  if (sellPromo != null && sellPrice != null && sellPromo >= sellPrice) {
                    return "Le prix promo doit inférieur au prix de vente";
                  }

                  final currency = saveProduct['currency'] == null ? null : saveProduct['currency'] as Currency;
                  if (sellPromo != null && currency != null && currency.verify_unit(sellPromo) == false) {
                    return "Prix invalide pour la monnaie choisi";
                  }

                  return null;
                }
            ).build(),
            onSaved: (value) {
              context.read<SaveProductFormCubit>().setValue('sell_in_promo', value, modules);
            },
          );
        }
    );
  }
}
