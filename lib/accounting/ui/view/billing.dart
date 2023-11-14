import 'package:flutter/material.dart';
import 'package:user_api/user_api.dart';

class AccountingBilling extends StatelessWidget {
  const AccountingBilling({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Billng'),
    );
  }
}
