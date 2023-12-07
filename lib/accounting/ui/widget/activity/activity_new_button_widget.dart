import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:organization_api/organization_api.dart';

import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';
import 'package:user_api/user_api.dart';

class ActivityNewButton extends StatelessWidget {
  const ActivityNewButton({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final productCategoryCubit = context.read<ProductCategoryCubit>();

    return ElevatedButton.icon(
      icon: const Icon(Icons.add, color: Colors.white,),
      onPressed: (){
        if (productCategoryCubit.state.isEmpty) {
          productCategoryCubit.getCategories(user.accessToken as String);
        }

        context.read<EditingProductCubit>().edit(null);
        context.read<ProductBottomNavigationCubit>().navigate(0);

        context.goNamed('productEdit',  extra: {
          'organizationContextMenuCubit': context.read<OrganizationContextMenuCubit>(), // need for the parent route
          'user': user,
          'productRepository': context.read<ProductRepository>(),
          'productCategoryApiStatusCubit': context.read<ProductCategoryApiStatusCubit>(),
          'productCategoryCubit': context.read<ProductCategoryCubit>(),
          'productCategoryConfigCubit': context.read<ProductCategoryConfigCubit>(),
          'currencyCubit': context.read<CurrencyCubit>(),
          'organizationCurrencyCubit': context.read<OrganizationCurrencyCubit>(),
          'productApiStatusCubit': context.read<ProductApiStatusCubit>(),
          'editingProductCubit': context.read<EditingProductCubit>(),
          'productBottomNavigationCubit': context.read<ProductBottomNavigationCubit>(),
        });
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue.shade700),
          fixedSize: MaterialStateProperty.resolveWith((states) => const Size.fromHeight(5))
      ),
      label: const Text('Nouveau', style: TextStyle(color: Colors.white),),
    );
  }
}
