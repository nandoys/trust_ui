import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:organization_api/organization_api.dart';

import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';
import 'package:user_api/user_api.dart';

class ActivityNewButton extends StatelessWidget {
  const ActivityNewButton({super.key, required this.user, required this.openEditProductView});

  final User user;
  final void Function(BuildContext context, User user) openEditProductView;

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

        openEditProductView.call(context, user);
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue.shade700),
          fixedSize: MaterialStateProperty.resolveWith((states) => const Size.fromHeight(5))
      ),
      label: const Text('Nouveau', style: TextStyle(color: Colors.white),),
    );
  }
}
