import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';

class ProductPerishSwitch extends StatelessWidget {
  const ProductPerishSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: BlocBuilder<SwitchPerishableCubit, bool>(
          builder: (_, isPerishable) {
            return SizedBox(
              width: 50,
              height: 30,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                    activeColor: Colors.blue.shade700,
                    value: isPerishable,
                    onChanged: (onChanged) {
                      context.read<SwitchPerishableCubit>().change(onChanged);
                      context.read<SaveProductFormCubit>().setValue('can_perish', onChanged);
                    }
                ),
              ),
            );
          }
      ),
    );
  }
}
