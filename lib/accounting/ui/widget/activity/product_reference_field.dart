import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:server_api/server_api.dart';
import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';
import 'package:user_api/user_api.dart';

class ProductReferenceField extends StatelessWidget {
  const ProductReferenceField({super.key, required this.user, required this.controller});

  final User user;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final token = user.accessToken;

    return BlocProvider(
      create: (context) => CheckProductReferenceFieldCubit(
        repository: context.read<ProductRepository>(),
        connectivityStatus: context.read<ConnectivityStatusCubit>(),
        apiStatus: context.read<ProductApiStatusCubit>()
      ),
      child: BlocBuilder<EditingProduct, Product?>(
          builder: (context, editProduct) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: BlocBuilder<CheckProductReferenceFieldCubit, bool>(
                  builder: (context, referenceExist) {

                    return Focus(
                        onFocusChange: (focus) {
                          if (!focus) {
                            if(controller.text.isNotEmpty && editProduct?.reference != controller.text) {
                              final organization = user.organization;
                              context.read<CheckProductReferenceFieldCubit>().checkField(organization,
                                  controller.text, token!);
                            }
                          }
                        },
                        child: TextFormField(
                          controller: controller,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            label: Text('Référence'),
                            isDense: true,
                            filled: true,
                          ),
                          validator: ValidationBuilder(localeName: 'fr', optional: true).add((value) {
                            if (referenceExist) {
                              return "Cette référence existe déjà";
                            }
                            return null;
                          }).build(),
                          onSaved: (value) {
                            context.read<SaveProductFormCubit>().setValue('reference', value);
                          },
                        )
                    );
                  }
              ),
            );
          }
      ),
    );
  }
}
