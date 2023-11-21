import 'package:flutter/material.dart';
import 'package:user_api/user_api.dart';

class AccountingMisc extends StatelessWidget {
  const AccountingMisc({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Miscellaneous'),
    );
  }
}
