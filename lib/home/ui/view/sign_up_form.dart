import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  TypeOrganisation? typeOrganisation;

  Country? country;

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
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          filled: true,
                          isDense: true,
                          labelText: "Nom de l'organisation*")
                  ),
                ),),
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: BlocBuilder<TypeOrganisationMenuCubit, List<TypeOrganisation>>(
                      builder: (context, typeMenus) {
                        return LayoutBuilder(builder: (context, constraints) {
                          return DropdownSearch<TypeOrganisation>(
                            items: typeMenus,
                            itemAsString: (TypeOrganisation typeOrganisation) => typeOrganisation.name,
                            validator: (value) {
                              if(value == null) {
                                return "Veuillez choisir le type d'organisation";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              typeOrganisation = value;
                            },
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: 'Type organisation*'
                                )
                            ),
                            popupProps: PopupProps.menu(
                              containerBuilder: (context, widget) {
                                return SizedBox(
                                  height: 100,
                                  child: widget,);
                              },
                                emptyBuilder: (context, text) {
                                  return const Center(
                                    child: SizedBox(
                                      height: 50.0,
                                      child: Text('Aucun type trouvé'),
                                    ),
                                  );
                                }
                            ),
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
                    child: BlocBuilder<CountryMenuCubit, List<Country>>(
                        builder: (context, countriesMenu) {
                          return LayoutBuilder(builder: (context, constraint) {
                            return DropdownSearch<Country>(
                              items: countriesMenu,
                              itemAsString: (Country country) => country.name,
                              validator: (value) {
                                if(value == null) {
                                  return "Veuillez choisir le pays";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                country = value;
                              },
                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  labelText: 'Pays*'
                                )
                              ),
                              popupProps: PopupProps.menu(
                                  emptyBuilder: (context, text) {
                                    return const Center(
                                      child: SizedBox(
                                        height: 50.0,
                                        child: Text('Aucun pays trouvé'),
                                      ),
                                    );
                                  }
                              ),
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
                    validator: ValidationBuilder(localeName: 'fr', optional: true).regExp(
                        RegExp(r'^[a-zA-Z0-9/,°.-]+$'),
                        'Veuillez entrer un numéro valide [a-z A-Z 0-9 ,°-./]'
                    ).build(),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          filled: true,
                          isDense: true,
                          labelText: "Adresse physique"),
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
                      validator: ValidationBuilder(localeName: 'fr', optional: true).email(
                        'Veuillez entrer une adresse valide'
                      ).build(),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                      validator: ValidationBuilder(localeName: 'fr', optional: true).regExp(
                        RegExp(r'^(\d+)$'), 'Veuillez entrer un numéro valide').phone(
                          'Veuillez entrer un numéro valide').build(),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                    validator: ValidationBuilder(localeName: 'fr', optional: true).regExp(
                        RegExp(r'^[a-zA-Z0-9/.]+$'),
                        'Veuillez entrer un numéro valide [a-z A-Z 0-9 . /]'
                    ).build(),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                      validator: ValidationBuilder(localeName: 'fr', optional: true).regExp(
                          RegExp(r'^[a-zA-Z0-9/.]+$'),
                          'Veuillez entrer un numéro valide [a-z A-Z 0-9 . /]'
                      ).build(),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                      validator: ValidationBuilder(localeName: 'fr', optional: true).regExp(
                          RegExp(r'^[a-zA-Z0-9/.]+$'),
                          'Veuillez entrer un numéro valide [a-z A-Z 0-9 . /]'
                      ).build(),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          filled: true,
                          isDense: true,
                          labelText: "Numéro Impôt")
                  ),
                ),),
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      controller: socialServiceController,
                      validator: ValidationBuilder(localeName: 'fr', optional: true).regExp(
                          RegExp(r'^[a-zA-Z0-9/.]+$'),
                          'Veuillez entrer un numéro valide [a-z A-Z 0-9 . /]'
                      ).build(),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                        validator: ValidationBuilder(localeName: 'fr', optional: true).regExp(
                            RegExp(r'^[a-zA-Z0-9/.]+$'),
                            'Veuillez entrer un numéro valide [a-z A-Z 0-9 . /]'
                        ).build(),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                        Organisation organisation = Organisation(
                            name: nameController.text,
                            address: addressController.text != '' ? addressController.text : null,
                            country: country as Country,
                            email: emailController.text != '' ? emailController.text : null,
                            telephone: phoneController.text != '' ? phoneController.text : null,
                            typeOrganisation: typeOrganisation as TypeOrganisation,
                            register: registerController.text != '' ? registerController.text : null,
                            idNat: idNatController.text != '' ? idNatController.text : null,
                            numeroImpot: taxController.text != '' ? taxController.text : null,
                            numeroSocial: socialServiceController.text != '' ? socialServiceController.text : null,
                            numeroEmployeur: employerController.text != '' ? employerController.text : null
                        );
                        context.read<OrganisationCubit>().create(organisation);
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
