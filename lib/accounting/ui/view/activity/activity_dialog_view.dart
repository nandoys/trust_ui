import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:trust_app/accounting/logic/cubit/cubit.dart';
import 'package:trust_app/accounting/ui/view/activity/product_accounting_view.dart';
import 'package:trust_app/accounting/ui/view/activity/product_info_view.dart';
import 'package:trust_app/accounting/ui/view/activity/product_taxes_view.dart';

class ActivityDialog extends StatelessWidget {
  const ActivityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final activityView = [
      ProductInfoView(),
      const ProductAccountingView(),
      const ProductTaxesView()
    ];

    return Dialog(
      elevation: 10.0,
      child: SizedBox(
        width: 850,
        height: 600,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductBottomNavigationCubit()),
            BlocProvider(create: (context) => SwitchPerishableCubit()),
            BlocProvider(create: (context) => SwitchInPromoCubit()),
          ],
          child: BlocBuilder<ProductBottomNavigationCubit, int>(
              builder: (context, viewIndex) {
                return Scaffold(
                  appBar: AppBar(
                    leading: const Row(),
                    title: const Text('Nouveau produit'),
                    centerTitle: true,
                    titleTextStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    ),
                  ),
                  body: activityView[viewIndex],
                  bottomNavigationBar: BottomNavigationBar(
                      onTap: (index) {
                        context.read<ProductBottomNavigationCubit>().navigate(index);
                      },
                      currentIndex: viewIndex,
                      selectedItemColor: Colors.blue.shade700,
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(FontAwesomeIcons.cartFlatbed), label: 'Produit'
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.book), label: 'Comptabilité'
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(FontAwesomeIcons.landmark), label: 'Taxe',
                        ),
                      ]
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.blue.shade700,
                    tooltip: 'Enregistrer',
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                );
              },
          ),
        ),
      ),
    );
  }
}
