import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organization_api/organization_api.dart';
import 'package:trust_app/accounting/ui/view/view.dart';
import 'package:user_api/user_api.dart';

class ActivityNewButton extends StatelessWidget {
  const ActivityNewButton({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add, color: Colors.white,),
      onPressed: (){
        context.read<ProductCategoryCubit>().getCategories(user.accessToken as String);
        showDialog(
            context: context,
            builder: (_) {
              return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: context.read<ProductCategoryApiStatusCubit>()),
                    BlocProvider.value(value: context.read<ProductCategoryConfigApiStatusCubit>()),
                    BlocProvider.value(value: context.read<ProductCategoryCubit>()),
                    BlocProvider.value(value: context.read<ProductCategoryConfigCubit>()),
                    BlocProvider.value(value: context.read<OrganizationCurrencyCubit>()),
                  ],
                  child: ActivityDialog(user: user,)
              );
            }
        );
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue.shade700),
          fixedSize: MaterialStateProperty.resolveWith((states) => const Size.fromHeight(5))
      ),
      label: const Text('Nouveau', style: TextStyle(color: Colors.white),),
    );
  }
}
