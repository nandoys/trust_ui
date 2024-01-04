import 'dart:async';

import 'package:accounting_api/accounting_api.dart';
import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:server_api/server_api.dart';
import 'package:trust_app/accounting/ui/datagrid/activity/product_accounting/datasource_product_accounting.dart';

import 'package:trust_app/accounting/ui/widget/accounting_widget.dart';
import 'package:trust_app/accounting/logic/cubit/cubit.dart';
import 'package:user_api/user_api.dart';

import 'package:trust_app/home/ui/widget/floating_snack_bar.dart';
import 'package:utils/utils.dart';

class ProductAccountingView extends StatefulWidget {
  const ProductAccountingView({super.key, required this.user});

  final User user;

  @override
  State<ProductAccountingView> createState() => _ProductAccountingViewState();
}

class _ProductAccountingViewState extends State<ProductAccountingView> {
  final scrollController = ScrollController();
  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final focusAccountNumber = FocusNode();
  bool loadingSave = false;
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {

    if (isEnabled) {
      Future.delayed(const Duration(milliseconds: 2), () {
        focusAccountNumber.requestFocus();
      });
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnchangeProductCategoryAccountCubit()),
        BlocProvider(create: (context) => UpdateAccountApiStatusCubit()),
        BlocProvider(create: (context) => UpdateAccountCubit(
            repository: context.read<AccountRepository>(),
            connectivityStatus: context.read<ConnectivityStatusCubit>(),
            apiStatus: context.read<UpdateAccountApiStatusCubit>()
        )),
      ],
      child: BlocBuilder<EditingProductCubit, Product?>(
        builder: (context, editProduct) {
          final accountDataSource = ProductAccountingDataSource(
              accounts: editProduct?.accounts ?? [],
              updateAccountCubit: context.read<UpdateAccountCubit>(),
              token: widget.user.accessToken as String
          );

          void saveAccount() {
            // save the account to the database
            formKey.currentState!.save();
            if (formKey.currentState!.validate()) {
              final Account? categoryAccount =  context.read<OnchangeProductCategoryAccountCubit>().state;
              final editProductCubit = context.read<EditingProductCubit>();

              setState(() {
                loadingSave = true;
              });

              editProductCubit.createAccount(
                  product: editProduct as Product,
                  account: categoryAccount as Account,
                  number: numberController.text,
                  name: nameController.text,
                  token: widget.user.accessToken as String
              ).then((data) {

                setState(() {
                  loadingSave = false;
                });

              }).catchError((onError) {
                Timer(const Duration(seconds: 2), () {
                  setState(() {
                    loadingSave = false;
                  });
                  SnackBar notif = FloatingSnackBar(
                      color: Colors.red,
                      message: onError.toString()
                  );

                  ScaffoldMessenger.of(context).showSnackBar(notif);
                });
              });

              formKey.currentState!.reset();
              numberController.text = '';

            }
          }

          return MultiBlocListener(
              listeners: [
                BlocListener<ConnectivityStatusCubit, ConnectivityStatus>(
                  listener: (context, connectivity) {
                    if (connectivity == ConnectivityStatus.disconnected) {
                      SnackBar notif = FloatingSnackBar(
                          color: Colors.red,
                          message: "Vous n'êtes pas connecté!"
                      );
                      ScaffoldMessenger.of(context).showSnackBar(notif);
                    }
                  },
                ),
                BlocListener<UpdateAccountApiStatusCubit, ApiStatus>(
                    listener: (context, apisStatus) {
                      final connectivity = context.read<ConnectivityStatusCubit>();
                      if (apisStatus == ApiStatus.failed && connectivity.state == ConnectivityStatus.connected) {
                        SnackBar notif = FloatingSnackBar(
                            color: Colors.red,
                            message: "Quelque chose s'est mal passé côté serveur!"
                        );
                        ScaffoldMessenger.of(context).showSnackBar(notif);
                      }
                      else if (apisStatus == ApiStatus.failed && connectivity.state == ConnectivityStatus.disconnected) {
                        SnackBar notif = FloatingSnackBar(
                            color: Colors.red,
                            message: "Vous n'êtes pas connecté!"
                        );
                        ScaffoldMessenger.of(context).showSnackBar(notif);
                      }
                    },
                ),
                BlocListener<UpdateAccountCubit, bool?>(
                    listener: (context, isUpdate) {
                      if(isUpdate == true) {
                        SnackBar notif = FloatingSnackBar(
                            color: Colors.green,
                            message: "Le compte  a été modifié!"
                        );
                        ScaffoldMessenger.of(context).showSnackBar(notif);
                      }
                      else if (isUpdate == false) {
                        SnackBar notif = FloatingSnackBar(
                            color: Colors.red,
                            message: "Le compte  n'a pas été modifié!"
                        );
                        ScaffoldMessenger.of(context).showSnackBar(notif);
                      }
                      context.read<UpdateAccountCubit>().setNull();
                    }
                )
              ],
              child: Column(
                children: [
                  Expanded(
                    flex: 0,
                    child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade700,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              clipBehavior: Clip.antiAlias,
                              width: constraints.maxWidth,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Compte comptable',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0
                                    ),
                                  ),
                                  if (editProduct?.name != null) Text(
                                    editProduct!.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                  const Expanded(
                      flex: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Text('Nouveau compte', textAlign: TextAlign.start,)
                          ],
                        ),
                      )
                  ),
                  Expanded(
                      child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                          child: AccountDropDownList(
                                            editProduct: editProduct,
                                            onChanged: (account) {
                                              context.read<OnchangeProductCategoryAccountCubit>().change(account);
                                              setState(() {
                                                isEnabled = true;
                                              });
                                            },
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      AccountNumberField(
                                        controller: numberController,
                                        enable: isEnabled,
                                        user: widget.user,
                                        focus: focusAccountNumber,
                                      ),
                                      AccountNameField(
                                          controller: nameController,
                                          enable: isEnabled,
                                          isLoading: loadingSave,
                                          saveAccount: saveAccount
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                      )
                  ),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SizedBox.expand(
                          child: AccountTable(accountingDataSource: accountDataSource,),
                        ),
                      )
                  )
                ],
              )
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    formKey.currentState?.dispose();
    focusAccountNumber.dispose();
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }
}
