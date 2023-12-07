import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';

class ProductNameField extends StatelessWidget {
  const ProductNameField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<EditingProductCubit, Product?>(
        builder: (context, editProduct) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: SizedBox(
              height: 40,
              child: TextFormField(
                controller: controller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: true,
                decoration: const InputDecoration(
                  label: Text('Nom du produit*'),
                  isDense: true,
                ),
                validator: (value) {
                  if(value == null ||  value.isEmpty) {
                    return "Veuillez entrer le nom du produit";
                  }
                  return null;
                },
                onSaved: (value) {
                  context.read<SaveProductFormCubit>().setValue('name', value);
                },
              ),
            ),
          );
        }
    );
  }
}
