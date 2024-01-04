import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:trust_app/accounting/ui/datagrid/activity/product_accounting/datasource_product_accounting.dart';

class AccountTable extends StatelessWidget {
  const AccountTable({super.key, required this.accountingDataSource});

  final ProductAccountingDataSource accountingDataSource;

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: accountingDataSource,
      columnWidthMode: ColumnWidthMode.fill,
      selectionMode: SelectionMode.single,
      navigationMode: GridNavigationMode.cell,
      verticalScrollPhysics: const BouncingScrollPhysics(),
      allowEditing: true,
      allowFiltering: true,
      onCellSecondaryTap: (detail) {
      },
      columns: [
        GridColumn(
            columnName: 'number',
            label: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Numéro de compte',
                )),
        ),
        GridColumn(
            columnName: 'name',
            label: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Intitulé de compte',
                ))),
      ],
      footer: accountingDataSource.rows.isEmpty ? const Center(
          child: Text('Aucun compte pour ce produit')
      ) : null,
    );
  }
}
