import 'package:accounting_api/accounting_api.dart';
import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_app/accounting/ui/datagrid/activity/product_accounting/datasource_product_accounting.dart';

import 'package:trust_app/accounting/ui/widget/accounting_widget.dart';
import 'package:trust_app/accounting/logic/cubit/cubit.dart';

class ProductAccountingView extends StatefulWidget {
  const ProductAccountingView({super.key});

  @override
  State<ProductAccountingView> createState() => _ProductAccountingViewState();
}

class _ProductAccountingViewState extends State<ProductAccountingView> {
  final scrollController = ScrollController();
  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final accounts = List.generate(15, (index) =>
        Account(number: "6011.000$index", name: "name $index", organization: null, accountType: null)
    );
    final accountDataSource = ProductAccountingDataSource(accounts: accounts);
    return BlocBuilder<EditingProductCubit, Product?>(
      builder: (context, editProduct) {

        void saveAccount() {
          // save the account to the database
          if (formKey.currentState!.validate()) {

          }
        }

        context.read<EnableNewAccountField>().disable();

        return Column(
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
                                      editProduct: editProduct as Product,
                                      onChanged: (account) {
                                        context.read<EnableNewAccountField>().enable();
                                      },
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: BlocBuilder<EnableNewAccountField, bool>(
                              builder: (context, isEnabled) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      AccountNumberField(
                                          controller: numberController,
                                          enable: isEnabled
                                      ),
                                      AccountNameField(
                                          controller: nameController,
                                          enable: isEnabled,
                                          saveAccount: saveAccount
                                      ),
                                    ],
                                  ),
                                );
                              }
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
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }
}
