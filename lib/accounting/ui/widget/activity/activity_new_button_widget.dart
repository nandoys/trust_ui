import 'package:flutter/material.dart';
import 'package:trust_app/accounting/ui/widget/activity/activity_dialog_widget.dart';

class ActivityNewButton extends StatelessWidget {
  const ActivityNewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add, color: Colors.white,),
      onPressed: (){
        showDialog(
            context: context,
            builder: (context) {
              return const ActivityDialog();
            }
        );
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue.shade700),
          fixedSize: MaterialStateProperty.resolveWith((states) => const Size.fromHeight(5))
      ),
      label: const Text('Nouveau', style: TextStyle(color: Colors.white),),
    );
  }
}
