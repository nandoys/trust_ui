import 'package:flutter/material.dart';
import 'package:trust_app/home/ui/widget/sign_up_form/email_field.dart';

class CreateUserAdminForm extends StatelessWidget {
  CreateUserAdminForm({super.key});
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Créer un super utilisateur', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  filled: true,
                  isDense: true,
                  labelText: 'Utilisateur'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: EmailField(controller: emailController),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                filled: true,
                isDense: true,
                labelText: 'Mot de passe',
                suffixIcon: GestureDetector(
                    onTap: () {

                    },
                    child: const Icon(1 == 1
                        ? Icons.visibility
                        : Icons.visibility_off)),
              ),
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                filled: true,
                isDense: true,
                labelText: 'Validation mot de passe',
                suffixIcon: GestureDetector(
                    onTap: () {

                    },
                    child: const Icon(1 == 1
                        ? Icons.visibility
                        : Icons.visibility_off)),
              ),
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: FilledButton(
              onPressed: () {
                print('pressed');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.blue),

              ),
              child: const Text('Enregistrer'),
            ),
          ),
        ],
      ),
    );
  }
}
