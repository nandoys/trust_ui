import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillWidget extends StatelessWidget {
  BillWidget({super.key});

  final billRowController = ScrollController();

  @override
  Widget build(BuildContext context) {
    const List<String> data = ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Nouvelle facture",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {},
                    child: const Text('Confirmer')
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: const Text('Aperçu')
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: const Text('Annuler')
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 10,
            child: Card
              (
              elevation: 0.2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                          child: DropdownSearch<String>(
                            items: data,
                            //itemAsString: (Country country) => country.name,
                            validator: (value) {
                              if(value == null) {
                                return "Veuillez choisir le client";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              //context.read<SelectedCountryCubit>().change(value);
                            },
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: 'Client*'
                                )
                            ),
                            popupProps: PopupProps.dialog(
                                showSearchBox: true,
                                searchFieldProps: const TextFieldProps(
                                  decoration: InputDecoration(
                                    label: Text('Recherche ...'),
                                    isDense: true,
                                    filled: true
                                  )
                                ),
                                emptyBuilder: (context, text) {
                                  return const Center(
                                    child: SizedBox(
                                      height: 50.0,
                                      child: Text('Aucun client trouvé'),
                                    ),
                                  );
                                }
                            ),
                          )
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 40.0),
                            child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Numéro de la facture*'),
                              isDense: true,
                            ),
                          ),
                          )
                      ),
                      Flexible(
                          child: Row(
                            children: [
                              Flexible(
                                  child: TextFormField(
                                decoration: const InputDecoration(
                                    label: Text('Date facturation*'),
                                    isDense: true
                                ),
                              )
                              ),
                              Flexible(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text("Date de l'échéance"),
                                        isDense: true
                                    ),
                                  )
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Flexible(
                          child: Row(
                            children: [
                              Flexible(
                                  child: DropdownSearch<String>(
                                items: const ['Journal Achat'],
                                //itemAsString: (Country country) => country.name,
                                validator: (value) {
                                  if(value == null) {
                                    return "Veuillez choisir le journal";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  //context.read<SelectedCountryCubit>().change(value);
                                },
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Journal*'
                                    )
                                ),
                                popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: const TextFieldProps(
                                        decoration: InputDecoration(
                                          label: Text('Recherche ...'),
                                          isDense: true,
                                        )
                                    ),
                                    emptyBuilder: (context, text) {
                                      return const Center(
                                        child: SizedBox(
                                          height: 50.0,
                                          child: Text('Aucun journal trouvé'),
                                        ),
                                      );
                                    }
                                ),
                              )
                              ),
                              Flexible(
                                  child: DropdownSearch<String>(
                                    items: const ['Franc congolais'],
                                    //itemAsString: (Country country) => country.name,
                                    validator: (value) {
                                      if(value == null) {
                                        return "Veuillez choisir la devise";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      //context.read<SelectedCountryCubit>().change(value);
                                    },
                                    dropdownDecoratorProps: const DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                            isDense: true,
                                            labelText: 'Devise*'
                                        )
                                    ),
                                    popupProps: PopupProps.menu(
                                        showSearchBox: true,
                                        searchFieldProps: const TextFieldProps(
                                            decoration: InputDecoration(
                                              label: Text('Recherche ...'),
                                              isDense: true,
                                            )
                                        ),
                                        emptyBuilder: (context, text) {
                                          return const Center(
                                            child: SizedBox(
                                              height: 50.0,
                                              child: Text('Aucun devise trouvée'),
                                            ),
                                          );
                                        }
                                    ),
                                  )
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              const Flexible(
                                  child: TabBar(
                                    tabs: [
                                        Tab(text: 'Ligne facture',),
                                        Tab(text: 'Ecriture comptable',),
                                      ],
                                    isScrollable: true,
                                    tabAlignment: TabAlignment.start,
                                  )
                              ),
                              Expanded(
                                flex: 10,
                                child: TabBarView(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                            child: SizedBox(
                                              height: 200,
                                              child: Scrollbar(
                                                  controller: billRowController,
                                                  thumbVisibility: true,
                                                  trackVisibility: true,
                                                  thickness: 3.5,
                                                  child: SingleChildScrollView(
                                                    controller: billRowController,
                                                    physics: const BouncingScrollPhysics(),
                                                    child: Table(
                                                      children: [
                                                        const TableRow(
                                                            children: [
                                                              Text('Produit'),
                                                              Text('Libellé'),
                                                              Text('Compte'),
                                                              Text('Quantité'),
                                                              Text('Taxe'),
                                                              Text('Prix HT'),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['Pomme tomate'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                          isDense: true,
                                                                          filled: true
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['7011 - Mse'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>.multiSelection(
                                                                  items: const ['7011', '7012'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupPropsMultiSelection.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucune taxe trouvée'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['Pomme tomate'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                          isDense: true,
                                                                          filled: true
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['7011 - Mse'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>.multiSelection(
                                                                  items: const ['7011', '7012'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupPropsMultiSelection.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucune taxe trouvée'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['Pomme tomate'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                          isDense: true,
                                                                          filled: true
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['7011 - Mse'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>.multiSelection(
                                                                  items: const ['7011', '7012'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupPropsMultiSelection.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucune taxe trouvée'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['Pomme tomate'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                          isDense: true,
                                                                          filled: true
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['7011 - Mse'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>.multiSelection(
                                                                  items: const ['7011', '7012'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupPropsMultiSelection.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucune taxe trouvée'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['Pomme tomate'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                          isDense: true,
                                                                          filled: true
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['7011 - Mse'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>.multiSelection(
                                                                  items: const ['7011', '7012'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupPropsMultiSelection.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucune taxe trouvée'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['Pomme tomate'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                          isDense: true,
                                                                          filled: true
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['7011 - Mse'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>.multiSelection(
                                                                  items: const ['7011', '7012'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupPropsMultiSelection.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucune taxe trouvée'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['Pomme tomate'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                          isDense: true,
                                                                          filled: true
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['7011 - Mse'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>.multiSelection(
                                                                  items: const ['7011', '7012'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupPropsMultiSelection.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucune taxe trouvée'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['Pomme tomate'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                          isDense: true,
                                                                          filled: true
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['7011 - Mse'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>.multiSelection(
                                                                  items: const ['7011', '7012'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupPropsMultiSelection.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucune taxe trouvée'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['Pomme tomate'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                          isDense: true,
                                                                          filled: true
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>(
                                                                  items: const ['7011 - Mse'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupProps.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucun produit trouvé'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: DropdownSearch<String>.multiSelection(
                                                                  items: const ['7011', '7012'],
                                                                  //itemAsString: (Country country) => country.name,
                                                                  validator: (value) {
                                                                    if(value == null) {
                                                                      return "Veuillez choisir le produit";
                                                                    }
                                                                    return null;
                                                                  },
                                                                  onSaved: (value) {
                                                                    //context.read<SelectedCountryCubit>().change(value);
                                                                  },
                                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                                      dropdownSearchDecoration: InputDecoration(
                                                                        isDense: true,
                                                                      )
                                                                  ),
                                                                  popupProps: PopupPropsMultiSelection.bottomSheet(
                                                                      showSearchBox: true,
                                                                      searchFieldProps: const TextFieldProps(
                                                                          decoration: InputDecoration(
                                                                            label: Text('Recherche ...'),
                                                                            isDense: true,
                                                                          )
                                                                      ),
                                                                      emptyBuilder: (context, text) {
                                                                        return const Center(
                                                                          child: SizedBox(
                                                                            height: 50.0,
                                                                            child: Text('Aucune taxe trouvée'),
                                                                          ),
                                                                        );
                                                                      }
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                child: TextFormField(
                                                                  decoration: const InputDecoration(),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Row(
                                              children: [
                                                TextButton(
                                                    onPressed: () {},
                                                    child: const Text('Ajouter ligne')
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                    child: Table(
                                                      columnWidths: const {
                                                        0: FixedColumnWidth(80),
                                                        1: FixedColumnWidth(180),
                                                      },
                                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                                      children: [
                                                        TableRow(
                                                            children: [
                                                              const Text('Total HT'),
                                                              SizedBox(
                                                                width: 100,
                                                                height: 20,
                                                                child: TextFormField(
                                                                  textAlign: TextAlign.end,
                                                                  style: const TextStyle(color: Colors.black),
                                                                  enabled: false,
                                                                  initialValue: "105 555",
                                                                  decoration: const InputDecoration(
                                                                      suffixStyle: TextStyle(color: Colors.black),
                                                                      suffixText: "\$"
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              const Text('Remise'),
                                                              SizedBox(
                                                                  width: 100,
                                                                  height: 20.0,
                                                                  child: TextFormField(
                                                                    textAlign: TextAlign.end,
                                                                    style: const TextStyle(color: Colors.black),
                                                                    decoration:  const InputDecoration(
                                                                        suffixStyle: TextStyle(color: Colors.black),
                                                                        suffixText: "%"
                                                                    ),
                                                                  )
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              const Text('Ristourne'),
                                                              SizedBox(
                                                                  width: 100,
                                                                  height: 20.0,
                                                                  child: TextFormField(
                                                                    textAlign: TextAlign.end,
                                                                    style: const TextStyle(color: Colors.black),
                                                                    decoration:  const InputDecoration(
                                                                        suffixStyle: TextStyle(color: Colors.black),
                                                                        suffixText: "%"
                                                                    ),
                                                                  )
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              const Text('Escompte'),
                                                              SizedBox(
                                                                  width: 100,
                                                                  height: 20.0,
                                                                  child: TextFormField(
                                                                    textAlign: TextAlign.end,
                                                                    style: const TextStyle(color: Colors.black),
                                                                    decoration:  const InputDecoration(
                                                                        suffixStyle: TextStyle(color: Colors.black),
                                                                        suffixText: "%"
                                                                    ),
                                                                  )
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              const Text('Total Taxe'),
                                                              SizedBox(
                                                                width: 100,
                                                                height: 20,
                                                                child: TextFormField(
                                                                  textAlign: TextAlign.end,
                                                                  style: const TextStyle(color: Colors.black),
                                                                  enabled: false,
                                                                  initialValue: "25 000",
                                                                  decoration: const InputDecoration(
                                                                      suffixStyle: TextStyle(color: Colors.black),
                                                                      suffixText: "\$"
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        TableRow(
                                                            children: [
                                                              const Text('Total TTC'),
                                                              SizedBox(
                                                                width: 100,
                                                                height: 20,
                                                                child: TextFormField(
                                                                  textAlign: TextAlign.end,
                                                                  style: const TextStyle(color: Colors.black),
                                                                  enabled: false,
                                                                  initialValue: "125 555",
                                                                  decoration: const InputDecoration(
                                                                      suffixStyle: TextStyle(color: Colors.black),
                                                                      suffixText: "\$"
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                          ),
                                        ],
                                      ),
                                      const Center(
                                        child: Text('Ecriture'),
                                      )
                                    ]
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                  )
                ],
              ),
            )
        )
      ],
    );
  }
}
