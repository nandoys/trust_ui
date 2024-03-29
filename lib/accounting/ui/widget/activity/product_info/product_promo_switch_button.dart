import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';
import 'package:user_api/user_api.dart';

class ProductPromoSwitch extends StatelessWidget {
  const ProductPromoSwitch({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchInPromoCubit, bool>(
        builder: (_, isPromo) {
          return BlocBuilder<EditingProductCubit, Product?>(
              builder: (context, editProduct) {
                return SizedBox(
                  width: 50,
                  height: 30,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Switch(
                        activeColor: Colors.blue.shade700,
                        value: editProduct?.id == null ? isPromo : editProduct!.inPromo,
                        onChanged: (onChanged) {
                          if (editProduct?.id == null) {
                            context.read<SwitchInPromoCubit>().change(onChanged);
                            context.read<SaveProductFormCubit>().setValue('in_promo', onChanged);
                          } else {
                            context.read<EditingProductCubit>().updateByField(editProduct!, 'in_promo',
                                onChanged, user.accessToken as String);
                          }

                        }
                    ),
                  ),
                );
              }
          );
        }
    );
  }
}
