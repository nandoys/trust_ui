import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_api/organisation_api.dart';

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
    return BlocBuilder<SignupLoadingCubit, bool>(builder: (context, loading) {
      return FilledButton(
          onPressed: !loading ? (){
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
              context.read<SignupLoadingCubit>().change(true);
            }
          } : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.blue),

          ),
          child: !loading ? const Text('Enregistrer') : const SizedBox(
              width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white,)
          )
      );
    });
  }


}
