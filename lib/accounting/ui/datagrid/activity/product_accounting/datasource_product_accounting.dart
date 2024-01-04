import 'dart:async';

import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:user_api/user_api.dart';
import 'package:trust_app/home/ui/widget/widget.dart';

class ProductAccountingDataSource extends DataGridSource {
  ProductAccountingDataSource({List<Account> accounts = const [], required this.updateAccountCubit, required this.user,
  required this.checkAccountCubit}) {
    accountsData = accounts;
    _accounts = accounts.map<DataGridRow>((account) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'number', value: account.number),
      DataGridCell<String>(columnName: 'name', value: account.name),
    ])).toList();
  }

  List<DataGridRow>  _accounts = [];
  List  accountsData = [];
  TextEditingController editingController = TextEditingController();
  final User user;
  final CheckAccountCubit checkAccountCubit;
  final UpdateAccountCubit updateAccountCubit;

  dynamic newCellValue;

  @override
  List<DataGridRow> get rows =>  _accounts;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(dataGridCell.value.toString()),
          );
        }).toList());
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, submitCell) {
    // To set the value for TextField when cell is moved into edit mode.
    final String displayText = dataGridRow
        .getCells()
        .firstWhere((DataGridCell dataGridCell) =>
    dataGridCell.columnName == column.columnName)
        .value
        ?.toString() ??
        '';

    if (column.columnName == 'number') {
      return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: TextField(
            autofocus: true,
            controller: editingController..text = displayText.split('.')[1],
            textAlign: TextAlign.right,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefix: Text('${displayText.split('.')[0]}.' ?? ''),
                isDense: true
            ),
            onChanged: (String value) {
              if (value.isNotEmpty) {
                newCellValue = value;
              } else {
                newCellValue = null;
              }
            },
            onSubmitted: (String value) {
              /// Call [CellSubmit] callback to fire the canSubmitCell and
              /// onCellSubmit to commit the new value in single place.
              submitCell();
            },
          ));
    }

    if (column.columnName == 'name') {
      return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: TextField(
            autofocus: true,
            controller: editingController..text = displayText,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true),
            onChanged: (String value) {
              if (value.isNotEmpty) {
                newCellValue = value;
              } else {
                newCellValue = null;
              }
            },
            onSubmitted: (String value) {
              /// Call [CellSubmit] callback to fire the canSubmitCell and
              /// onCellSubmit to commit the new value in single place.
              submitCell();
            },
          ));
    }

    return null;
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) async {
    final dynamic oldValue = dataGridRow
        .getCells()
        .firstWhere((DataGridCell dataGridCell) =>
    dataGridCell.columnName == column.columnName).value ?? '';

    final int dataRowIndex = rows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
     return;
    }

    if (column.columnName == 'number') {
      final mainAccount = accountsData[dataRowIndex].number.toString().split('.')[0];
      final accountToCheck = '$mainAccount.$newCellValue';

      await checkAccountCubit.checkAccount(
          organization: user.organization,
          number: accountToCheck,
          token: user.accessToken as String
      );

      if(!checkAccountCubit.state) {

        final oldCellValue = accountsData[dataRowIndex].number;
        accountsData[dataRowIndex].number = accountToCheck;

        await updateAccountCubit.update(field: 'number', account: accountsData[dataRowIndex],
            token: user.accessToken as String).then(
                (value) {
              rows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
                  DataGridCell (columnName: 'number', value: accountToCheck);
            }
        ).onError((error, stackTrace) {
          accountsData[dataRowIndex].number = oldCellValue;
        });
      }

    }

    if (column.columnName == 'name') {
      final oldCellValue = accountsData[dataRowIndex].name;
      accountsData[dataRowIndex].name = newCellValue;

      await updateAccountCubit.update(field: 'name', account: accountsData[dataRowIndex],
          token: user.accessToken as String).then(
              (value) {
                rows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell (columnName: 'name', value: newCellValue);
              }
      ).onError((error, stackTrace) {
        accountsData[dataRowIndex].name = oldCellValue;
      });
    }

    // To reset the new cell value after successfully updated to DataGridRow
    //and underlying mode.
    newCellValue = null;
  }

}