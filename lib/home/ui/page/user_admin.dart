import 'package:flutter/material.dart';
import 'package:trust_app/home//ui/view/view.dart';

class CreateUserAdminPage extends StatelessWidget {
  const CreateUserAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60.withOpacity(0.4),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * 0.65,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0)
            ),
            child: CreateUserAdminForm(),
          ),
        ),
      ),
    );
  }
}
