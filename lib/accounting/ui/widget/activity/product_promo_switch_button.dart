import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';

class ProductPromoSwitch extends StatelessWidget {
  const ProductPromoSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchInPromoCubit, bool>(
        builder: (_, isPromo) {
          return SizedBox(
            width: 50,
            height: 30,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Switch(
                  activeColor: Colors.blue.shade700,
                  value: isPromo,
                  onChanged: (onChanged) {
                    context.read<SwitchInPromoCubit>().change(onChanged);
                    context.read<SaveProductFormCubit>().setValue('in_promo', onChanged);
                  }
              ),
            ),
          );
        }
    );
  }
}
