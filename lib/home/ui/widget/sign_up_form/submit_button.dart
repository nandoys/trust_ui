import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_api/organisation_api.dart';

import 'package:trust_app/home/logic/cubit/cubit.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.formKey, required this.name, required this.address, required this.email,
    required this.phone, required this.register, required this.idNat, required this.tax, required this.socialSecurity,
    required this.employer});

  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController address;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController register;
  final TextEditingController idNat;
  final TextEditingController tax;
  final TextEditingController socialSecurity;
  final TextEditingController employer;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: (){
          if (formKey.currentState!.validate()) {
            formKey.currentState?.save();
            Organisation organisation = Organisation(
                name: name.text,
                address: address.text != '' ? address.text : null,
                country: context.read<SelectedCountryCubit>().state as Country,
                email: email.text != '' ? email.text : null,
                telephone: phone.text != '' ? phone.text : null,
                typeOrganisation: context.read<SelectedTypeOrganisationCubit>().state as TypeOrganisation,
                register: register.text != '' ? register.text : null,
                idNat: idNat.text != '' ? idNat.text : null,
                numeroImpot: tax.text != '' ? tax.text : null,
                numeroSocial: socialSecurity.text != '' ? socialSecurity.text : null,
                numeroEmployeur: employer.text != '' ? employer.text : null
            );
            context.read<OrganisationCubit>().create(organisation);
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.blue),

        ),
        child: const Text('Enregistrer')
    );
  }
}
