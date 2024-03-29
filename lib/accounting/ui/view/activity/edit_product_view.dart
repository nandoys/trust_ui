import 'package:accounting_api/accounting_api.dart';
import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organization_api/organization_api.dart';

import 'package:trust_app/accounting/logic/cubit/cubit.dart';
import 'package:trust_app/accounting/ui/view/activity/product_accounting_view.dart';
import 'package:trust_app/accounting/ui/view/activity/product_info_view.dart';
import 'package:trust_app/accounting/ui/view/activity/product_taxes_view.dart';
import 'package:user_api/user_api.dart';
import 'package:trust_app/home/ui/widget/widget.dart';
import 'package:utils/utils.dart' as helper;

class EditProductView extends StatelessWidget {
  EditProductView({super.key, required this.user, required this.productCategoryApiStatusCubit, required this.productsCubit,
    required this.productCategoryCubit, required this.productCategoryConfigCubit, required this.currencyCubit,
    required this.organizationCurrencyCubit, required this.productApiStatusCubit, required this.editingProductCubit,
    required this.productBottomNavigationCubit, required this.repository, required this.accountRepository});
  final User user;
  final ProductRepository repository;
  final AccountRepository accountRepository;
  final ProductCategoryApiStatusCubit productCategoryApiStatusCubit;
  final ProductsCubit productsCubit;
  final ProductCategoryCubit productCategoryCubit;
  final ProductCategoryConfigCubit productCategoryConfigCubit;
  final OrganizationCurrencyCubit organizationCurrencyCubit;
  final CurrencyCubit currencyCubit;
  final ProductApiStatusCubit productApiStatusCubit;
  final EditingProductCubit editingProductCubit;
  final ProductBottomNavigationCubit productBottomNavigationCubit;
  final GlobalKey<FormState> formProductKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: repository,
          ),
          RepositoryProvider.value(
            value: accountRepository,
          )
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: productCategoryApiStatusCubit),
              BlocProvider.value(value: productCategoryCubit),
              BlocProvider.value(value: productCategoryConfigCubit),
              BlocProvider.value(value: currencyCubit),
              BlocProvider.value(value: organizationCurrencyCubit),
              BlocProvider.value(value: productApiStatusCubit),
              BlocProvider.value(value: editingProductCubit),
              BlocProvider.value(value: productBottomNavigationCubit),
            ],
            child: BlocBuilder<EditingProductCubit, Product?>(
                builder: (context, editingProduct) {
                  final activityView = [
                    ProductInfoView(product: editingProduct, user: user, formKey: formProductKey),
                    ProductAccountingView(user: user,),
                    const ProductTaxesView()
                  ];

                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => SwitchPerishableCubit()),
                      BlocProvider(create: (context) => SwitchInPromoCubit()),
                      BlocProvider(create: (context) => SaveProductFormCubit(user: user)),
                    ],
                    child: BlocListener<ProductApiStatusCubit, helper.ApiStatus>(
                      listener: (BuildContext context, apiStatus) {
                        final action = context.read<ProductApiStatusCubit>().action;
                        final view = context.read<ProductApiStatusCubit>().view;

                        if(apiStatus == helper.ApiStatus.succeeded && action == helper.Actions.create
                            && view == 'productInfo') {
                          SnackBar notif = FloatingSnackBar(
                              color: Colors.green,
                              message: "Votre produit a été ajouté!"
                          );
                          context.read<ProductBottomNavigationCubit>().navigate(1);
                          ScaffoldMessenger.of(context).showSnackBar(notif);
                        }
                        else if(apiStatus == helper.ApiStatus.succeeded && action == helper.Actions.create
                            && view == 'productAccount') {
                          SnackBar notif = FloatingSnackBar(
                              color: Colors.green,
                              message: "Le compte  a été ajouté!"
                          );
                          context.read<ProductBottomNavigationCubit>().navigate(1);
                          ScaffoldMessenger.of(context).showSnackBar(notif);
                        }
                        else if(apiStatus == helper.ApiStatus.succeeded && action == helper.Actions.update
                        && view == 'productInfo') {
                          SnackBar notif = FloatingSnackBar(
                              color: Colors.green,
                              message: "Votre produit a été modifié avec succès!"
                          );
                          ScaffoldMessenger.of(context).showSnackBar(notif);
                        }
                        else if(apiStatus == helper.ApiStatus.failed && action == null && view == 'productInfo') {
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
                              context.read<EditingProductCubit>().createProduct(
                                  product: product,
                                  token: user.accessToken as String,
                                  productsCubit: productsCubit
                              );
                            }
                          }

                          void editProduct() {
                            formProductKey.currentState?.save();
                            if(formProductKey.currentState!.validate()) {
                              print('edit button');
                            }
                          }

                          final bottomNavigation = context.read<ProductBottomNavigationCubit>();

                          return Scaffold(
                            appBar: AppBar(
                              title: Text(editingProduct?.id == null ? 'Nouveau produit' : 'Modifier produit'),
                              centerTitle: true,
                              titleTextStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black
                              ),
                            ),
                            body: Center(
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return SizedBox(
                                      width: constraints.maxWidth * 0.70,
                                      height: constraints.maxHeight * 0.90,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 50,
                                        shadowColor: Colors.blue.shade700,
                                        child: Container(
                                          color: Colors.white,
                                          child: activityView[viewIndex],
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            ),
                            bottomNavigationBar: BottomNavigationBar(
                                onTap: editingProduct != null ? (index) {
                                  bottomNavigation.navigate(index);
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
                            floatingActionButton: bottomNavigation.state == 0 ? FloatingActionButton(
                              onPressed: editingProduct?.id == null ? saveProduct : editProduct,
                              backgroundColor: Colors.blue.shade700,
                              tooltip: editingProduct?.id == null ? 'Enregistrer' : 'Modifier',
                              child: Icon(
                                editingProduct?.id == null ? Icons.add : Icons.edit,
                                color: Colors.white,
                              ),
                            ) : null,
                          );
                        },
                      ),
                    ),
                  );
                }
            )
        )
    );
  }
}
