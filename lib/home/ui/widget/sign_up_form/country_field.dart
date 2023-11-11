import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:organisation_api/organisation_api.dart';
import 'package:utils/utils.dart';

import 'package:trust_app/home/ui/widget/widget.dart';

class CountryField extends StatelessWidget {
  const CountryField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CountryApiStatusCubit, ApiStatus>(
      listener: (context, status) {
        SnackBar notif = FloatingSnackBar(
            color: Colors.red,
            message: "Impossible de récupérer les pays."
        );

        ScaffoldMessenger.of(context).showSnackBar(notif);
      },
      listenWhen: (previous, current) {
        return current == ApiStatus.failed;
      },
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
                onSaved: (value) {
                  context.read<SelectedCountryCubit>().change(value);
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
      ),
    );
  }
}
