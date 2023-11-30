import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';

class ProductCodebarField extends StatelessWidget {
  const ProductCodebarField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
          label: Text('Code barre'),
          isDense: true,
          filled: true,
        ),
        onSaved: (value) {
          context.read<SaveProductFormCubit>().setValue('codebar', value);
        },
      ),
    );
  }
}
