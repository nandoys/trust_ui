import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Connexion',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)
          ),
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
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
            child: FilledButton(
              onPressed: () {  },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.blue),

              ),
              child: const Text('Se connecter'),
            ),
          ),
        ],
      ),
    );
  }
}
