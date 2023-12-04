import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';

class ProductCodebarField extends StatelessWidget {
  const ProductCodebarField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditingProduct, Product?>(
        builder: (context, editProduct) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFormField(
              controller: controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                label: Text('Code barre'),
                isDense: true,
                filled: true,
              ),
              onSaved: (value) {
                context.read<SaveProductFormCubit>().setValue('barcode', value);
              },
            ),
          );
        }
    );
  }
}
