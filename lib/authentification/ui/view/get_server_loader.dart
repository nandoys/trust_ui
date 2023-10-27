import 'package:flutter/material.dart';


class WaitServerLoader extends StatelessWidget {
  const WaitServerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.3),
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 2.0,
                )),
            SizedBox(
              width: 4.0,
            ),
            Text(
              'Recherche serveur...',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              width: 4.0,
            ),
          ],
        ),
      ),
    );
  }
}
