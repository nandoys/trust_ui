import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

import 'package:trust_app/home/ui/widget/widget.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final registerController = TextEditingController();

  final idNatController = TextEditingController();

  final taxController = TextEditingController();

  final socialSecurityController = TextEditingController();

  final employerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetupOrganisationCubit, Organisation?>(
      listener: (context, organisation) {
        context.goNamed('createAdmin', extra: organisation);
      },
      listenWhen: (previous, current) => current != null,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Information générale', textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500)),
                ),
              ],
            ),

            Row(
              children: [
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: NameField(controller: nameController,),
                ),),
                const Flexible(child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TypeOrganisationField(),
                ),),
              ],
            ),

            Row(
              children: [
                const Flexible(child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CountryField()
                )),
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AddressField(controller: addressController,),
                ))
              ],
            ),

            Row(
              children: [
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: EmailField(controller: emailController,),
                ),),
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: PhoneField(controller: phoneController,),
                ))
              ],
            ),

            const Row(children: [
              Flexible(child: Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 6.0),
                child: Text('Information légale', textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),),
              ))
            ],),

            Row(
              children: [
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RegisterField(controller: registerController,),
                ),),
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IdNatField(controller: idNatController,),
                ),)
              ],
            ),

            Row(
              children: [
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TaxField(controller: taxController,),
                ),),
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SocialSecurityField(controller: socialSecurityController,),
                ),)
              ],
            ),

            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: EmployerField(controller: employerController,),
                  ),
                ),
                Flexible(child: Container())
              ],
            ),

            Row(children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SubmitButton(formKey: _formKey, name: nameController, address: addressController,
                  email: employerController, phone: phoneController, register: registerController,
                  idNat: idNatController, socialSecurity: socialSecurityController, tax: taxController,
                  employer: employerController,),
              )
            ],)
          ],
        )
    ),
    );
  }
}
