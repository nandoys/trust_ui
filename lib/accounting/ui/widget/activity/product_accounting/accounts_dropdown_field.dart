import 'package:accounting_api/accounting_api.dart';
import 'package:activity_api/activity_api.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AccountDropDownList extends StatelessWidget {
  const AccountDropDownList({super.key, required this.editProduct, this.onChanged});

  final Product editProduct;
  final void Function(Account?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Account>(
      autoValidateMode: AutovalidateMode.onUserInteraction,
      items: editProduct.productCategory.subAccounts,
      itemAsString: (account) => '${account.number} ${account.name}',
      validator: (value) {
        if(value == null) {
          return "Veuillez choisir le compte";
        }
        return null;
      },
      onChanged: onChanged,
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            filled: true,
            labelText: 'Compte*',
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0)
        ),
      ),
      dropdownButtonProps: const DropdownButtonProps(),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchDelay: const Duration(milliseconds: 0),
        searchFieldProps: const TextFieldProps(
            autofocus: true,
            decoration: InputDecoration(
                label: Text('Rechercher'),
                prefixIcon: Icon(Icons.search),
                isDense: true,
                filled: true
            )
        ),
        constraints: const BoxConstraints(
            maxHeight: 200
        ),
        scrollbarProps: const ScrollbarProps(
            thumbVisibility: true
        ),
        emptyBuilder: (context, text) {
          return Center(
            child: SizedBox(
              height: 80.0,
              child: Column(
                children: [
                  const Text('Aucun compte trouvé'),
                  TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh),
                      label: const Text('Rafraîchir')
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
