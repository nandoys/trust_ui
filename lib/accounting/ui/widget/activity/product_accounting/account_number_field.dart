import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:server_api/server_api.dart';

import 'package:trust_app/accounting/logic/cubit/activity/activity_cubit.dart';
import 'package:user_api/user_api.dart';

class AccountNumberField extends StatelessWidget {
  const AccountNumberField({super.key, required this.controller, required this.enable, required this.user});

  final TextEditingController controller;
  final bool enable;
  final User user;

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CheckAccountApiStatusCubit()),
          BlocProvider(
            create: (context) => CheckAccountCubit(
                repository: context.read<AccountRepository>(),
                connectivityStatus: context.read<ConnectivityStatusCubit>(),
                apiStatus: context.read<CheckAccountApiStatusCubit>()
            ),
          )
        ],
        child: Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: BlocBuilder<OnchangeProductCategoryAccountCubit, Account?>(
                builder: (context, account) {
                  return Focus(
                      onFocusChange: (focus){
                        if(!focus) {
                          if(controller.text.isNotEmpty) {
                            final accountToCheck = '${account?.number}${controller.text}';
                            context.read<CheckAccountCubit>().checkAccount(
                                organization: user.organization,
                                number: accountToCheck,
                                token: user.accessToken as String
                            );
                          }
                        }
                      },
                      child: BlocBuilder<CheckAccountCubit, bool>(
                          builder: (context, accountExist) {
                            return TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              enabled: enable,
                              controller: controller,
                              validator: ValidationBuilder(
                                  requiredMessage: 'Numéro de compte obligatoire'
                              ).regExp(RegExp(r'^[0-9]+$'), 'Numéro invalide').add((value) {
                                if (accountExist) {
                                  return "Cette adresse email existe déjà";
                                }
                                return null;
                              }).build(),
                              decoration: InputDecoration(
                                  label: const Text("Numéro de compte*"),
                                  prefix: Text(account?.number ?? '')
                              ),
                            );
                          }
                      )
                  );
                }
            ),
          ),
        )
    );
  }
}
