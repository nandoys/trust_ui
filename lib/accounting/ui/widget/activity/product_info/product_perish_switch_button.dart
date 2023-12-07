import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';
import 'package:user_api/user_api.dart';

class ProductPerishSwitch extends StatelessWidget {
  const ProductPerishSwitch({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: BlocBuilder<SwitchPerishableCubit, bool>(
          builder: (_, isPerishable) {
            return BlocBuilder<EditingProductCubit, Product?>(
                builder: (context, editProduct) {
                  return SizedBox(
                    width: 50,
                    height: 30,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Switch(
                          activeColor: Colors.blue.shade700,
                          value: editProduct?.id == null ? isPerishable : editProduct?.canPerish as bool,
                          onChanged: (onChanged) {
                            if (editProduct?.id == null) {
                              context.read<SwitchPerishableCubit>().change(onChanged);
                              context.read<SaveProductFormCubit>().setValue('can_perish', onChanged);
                            }
                            else {
                              context.read<EditingProductCubit>().updateByField(editProduct!, 'can_perish',
                                  onChanged, user.accessToken as String);
                            }
                          }
                      ),
                    ),
                  );
                }
            );
          }
      ),
    );
  }
}
