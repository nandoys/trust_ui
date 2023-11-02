import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final typeOrganisationController = TextEditingController();
  final countryController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final registerController = TextEditingController();
  final idNatController = TextEditingController();
  final taxController = TextEditingController();
  final socialServiceController = TextEditingController();
  final employerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
                  child: TextFormField(
                      autofocus: true,
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Veuillez entrer le nom de votre organisation";
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                          filled: true,
                          isDense: true,
                          labelText: "Nom de l'organisation*")
                  ),
                ),),
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: BlocBuilder<TypeOrganisationMenuCubit, List<DropdownMenuEntry<dynamic>>>(
                      builder: (context, typeMenus) {
                        return LayoutBuilder(builder: (context, constraints) {
                          return DropdownMenu(
                            dropdownMenuEntries: typeMenus,
                            controller: typeOrganisationController,
                            enableSearch: true,
                            enableFilter: true,
                            width: constraints.maxWidth,
                            inputDecorationTheme: const InputDecorationTheme(
                              isDense: true,
                              filled: true,
                            ),
                            label: const Text("Type d'organisation*"),
                            hintText: 'Déterminera le plan comptable',
                          );
                        });
                      }
                  ),
                ),),
              ],
            ),

            Row(
              children: [
                Flexible(child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: BlocBuilder<CountryMenuCubit, List<DropdownMenuEntry<dynamic>>>(
                        builder: (context, countryMenu) {
                          return LayoutBuilder(builder: (context, constraint) {
                            return DropdownMenu(
                              dropdownMenuEntries: countryMenu,
                              controller: countryController,
                              enableFilter: true,
                              enableSearch: true,
                              width: constraint.maxWidth,
                              inputDecorationTheme: const InputDecorationTheme(
                                isDense: true,
                                filled: true,
                              ),
                              label: const Text("Pays*"),
                              hintText: 'Déterminera la fiscalité, monnaie locale...',
                            );
                          });
                        }
                    )
                )),
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.streetAddress,
                      decoration: const InputDecoration(
                          filled: true,
                          isDense: true,
                          labelText: "Adresse physique")
                  ),
                ))
              ],
            ),

            Row(
              children: [
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          filled: true,
                          isDense: true,
                          labelText: "Adresse email")
                  ),
                ),),
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          filled: true,
                          isDense: true,
                          labelText: "Téléphone")
                  ),
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
                  child: TextFormField(
                    controller: registerController,
                    decoration: const InputDecoration(
                        filled: true,
                        isDense: true,
                        labelText: "Numéro d'enregistrement",
                        hintText: 'Registre de commerce, personnalité juridique'
                    ),
                  ),
                ),),
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                      controller: idNatController,
                      decoration: const InputDecoration(
                          filled: true,
                          isDense: true,
                          labelText: "Identification Nationale")
                  ),
                ),)
              ],
            ),

            Row(
              children: [
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      controller: taxController,
                      decoration: const InputDecoration(
                          filled: true,
                          isDense: true,
                          labelText: "Numéro Impôt")
                  ),
                ),),
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      controller: socialServiceController,
                      decoration: const InputDecoration(
                          filled: true,
                          isDense: true,
                          labelText: "Numéro Sécurité sociale")
                  ),
                ),)
              ],
            ),

            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                        controller: employerController,
                        decoration: const InputDecoration(
                            filled: true,
                            isDense: true,
                            labelText: "Numéro employeur")
                    ),
                  ),
                ),
                Flexible(child: Container())
              ],
            ),

            Row(children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FilledButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.blue),

                    ),
                    child: const Text('Enregistrer')
                ),
              )
            ],)
          ],
        )
    );
  }
}
