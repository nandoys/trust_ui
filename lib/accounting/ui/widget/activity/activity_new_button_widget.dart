import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_app/accounting/ui/view/view.dart';

class ActivityNewButton extends StatelessWidget {
  const ActivityNewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add, color: Colors.white,),
      onPressed: (){
        context.read<ProductCategoryCubit>().getCategories();
        showDialog(
            context: context,
            builder: (_) {
              return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: context.read<ProductCategoryApiStatusCubit>()),
                    BlocProvider.value(value: context.read<ProductCategoryCubit>())
                  ],
                  child: const ActivityDialog()
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
