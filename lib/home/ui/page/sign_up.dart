import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white60.withOpacity(0.4),
        body: Center(
          child: SizedBox.fromSize(
            size: Size(width * 0.60, height * 0.90),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    title: const Text('Nouvelle Organisation'),
                    centerTitle: true,
                    titleTextStyle: const TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Form(
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
                                          decoration: const InputDecoration(
                                              filled: true,
                                              isDense: true,
                                              labelText: "Nom de l'organisation*")
                                      ),
                                    ),),
                                    Flexible(child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: LayoutBuilder(builder: (context, constraints) {
                                        return DropdownMenu(
                                          dropdownMenuEntries: const [
                                            DropdownMenuEntry(value: 'value', label: 'Association'),
                                            DropdownMenuEntry(value: 'value2', label: 'Entreprise'),
                                          ],
                                          controller: typeOrganisationController,
                                          enableSearch: true,
                                          enableFilter: true,
                                          width: constraints.maxWidth,
                                          inputDecorationTheme: InputDecorationTheme(
                                            isDense: true,
                                            filled: true,
                                          ),
                                          label: const Text("Type d'organisation*"),
                                          hintText: 'Déterminera le plan comptable',
                                        );
                                      }),
                                    ),)
                                  ],
                                ),

                                Row(
                                  children: [
                                    Flexible(child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: LayoutBuilder(builder: (context, constraint) {
                                        return DropdownMenu(
                                          dropdownMenuEntries: const [
                                            DropdownMenuEntry(value: 'value', label: 'RDC'),
                                            DropdownMenuEntry(value: 'value2', label: 'Congo'),
                                          ],
                                          controller: countryController,
                                          width: constraint.maxWidth,
                                          inputDecorationTheme: const InputDecorationTheme(
                                            isDense: true,
                                            filled: true,
                                          ),
                                          label: Text("Pays*"),
                                          hintText: 'Déterminera la fiscalité, monnaie locale...',
                                        );
                                      }),
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
                                        onPressed: (){},
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.resolveWith(
                                                    (states) => Colors.green),

                                        ),
                                        child: const Text('Enregistrer')
                                    ),
                                  )
                                ],)
                              ],
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
