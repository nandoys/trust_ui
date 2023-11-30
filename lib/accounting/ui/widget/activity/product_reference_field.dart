import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';

class ProductReferenceField extends StatelessWidget {
  const ProductReferenceField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
          label: Text('Référence'),
          isDense: true,
          filled: true,
        ),
        onSaved: (value) {
          context.read<SaveProductFormCubit>().setValue('reference', value);
        },
      ),
    );
  }
}
