import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:trust_app/accounting/logic/cubit/cubit.dart';
import 'package:trust_app/accounting/ui/view/activity/product_accounting_view.dart';
import 'package:trust_app/accounting/ui/view/activity/product_info_view.dart';
import 'package:trust_app/accounting/ui/view/activity/product_taxes_view.dart';
import 'package:user_api/user_api.dart';
import 'package:trust_app/home/ui/widget/widget.dart';
import 'package:utils/utils.dart';

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
                child: BlocListener<ProductApiStatusCubit, ApiStatus>(
                  listener: (BuildContext context, apiStatus) {
                    if(apiStatus == ApiStatus.succeeded) {
                      SnackBar notif = FloatingSnackBar(
                          color: Colors.green,
                          message: "Votre produit a été ajouté!"
                      );
                      context.read<ProductBottomNavigationCubit>().navigate(1);
                      ScaffoldMessenger.of(context).showSnackBar(notif);
                    }
                    else if(apiStatus == ApiStatus.failed) {
                      SnackBar notif = FloatingSnackBar(
                          color: Colors.red,
                          message: "Votre produit n'a été ajouté! quelque chose s'est mal passé"
                      );
                      ScaffoldMessenger.of(context).showSnackBar(notif);
                    }
                  },
                  //listenWhen: (previous, current) => current.runtimeType == ProductApiStatusCubit,
                  child: BlocBuilder<ProductBottomNavigationCubit, int>(
                    builder: (context, viewIndex) {
                      void saveProduct() {
                        formProductKey.currentState?.save();
                        if(formProductKey.currentState!.validate()) {
                          final form = context.read<SaveProductFormCubit>().state;
                          final product = Product.fromJson(form);
                          context.read<EditingProduct>().createProduct(product, user.accessToken as String);
                        }
                      }

                      void editProduct() {
                        print('hey, im editing your product ....');
                      }

                      return Scaffold(
                        appBar: AppBar(
                          leading: const Row(),
                          title: Text(editingProduct?.id == null ? 'Nouveau produit' : 'Modifier produit'),
                          centerTitle: true,
                          titleTextStyle: const TextStyle(
                              fontSize: 16,
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
                          onPressed: editingProduct?.id == null ? saveProduct : editProduct,
                          backgroundColor: Colors.blue.shade700,
                          tooltip: editingProduct?.id == null ? 'Enregistrer' : 'Modifier',
                          child: Icon(
                            editingProduct?.id == null ? Icons.add : Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
