import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:trust_app/accounting/logic/cubit/cubit.dart';
import 'package:trust_app/accounting/ui/view/activity/product_accounting_view.dart';
import 'package:trust_app/accounting/ui/view/activity/product_info_view.dart';
import 'package:trust_app/accounting/ui/view/activity/product_taxes_view.dart';
import 'package:user_api/user_api.dart';

class ActivityDialog extends StatelessWidget {
  ActivityDialog({super.key, required this.user});
  final User user;
  final GlobalKey<FormState> formProductKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<EditingProduct, Product?>(
        builder: (context, editingProduct) {
          final activityView = [
            ProductInfoView(product: editingProduct, user: user, formKey: formProductKey),
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
                  BlocProvider(create: (context) => SaveProductFormCubit(user: user)),
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
                          onTap: editingProduct != null ? (index) {
                            context.read<ProductBottomNavigationCubit>().navigate(index);
                          } : null,
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
                        onPressed: () {
                          formProductKey.currentState?.save();
                          if(formProductKey.currentState!.validate()) {
                            final form = context.read<SaveProductFormCubit>().state;
                            final product = Product.fromJson(form);
                            context.read<EditingProduct>().createProduct(product, user.accessToken as String);
                          }
                        },
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
    );
  }
}
