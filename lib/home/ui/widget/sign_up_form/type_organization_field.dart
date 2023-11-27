import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:organization_api/organization_api.dart';
import 'package:utils/utils.dart';

import 'package:trust_app/home/ui/widget/widget.dart';

class TypeOrganisationField extends StatelessWidget {
  const TypeOrganisationField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrganizationTypeApiStatusCubit, ApiStatus>(
      listener: (context, status) {
        SnackBar notif = FloatingSnackBar(
            color: Colors.red,
            message: "Impossible de récupérer les type d'organisation."
        );

        ScaffoldMessenger.of(context).showSnackBar(notif);
      },
      listenWhen: (previous, current) {
        return current == ApiStatus.failed;
      },
      child: BlocBuilder<OrganizationTypeMenuCubit, List<OrganizationType>>(
          builder: (context, typeMenus) {
            return LayoutBuilder(builder: (context, constraints) {
              return DropdownSearch<OrganizationType>(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                items: typeMenus,
                itemAsString: (OrganizationType organizationType) => organizationType.name,
                validator: (value) {
                  if(value == null) {
                    return "Veuillez choisir le type d'organisation";
                  }
                  return null;
                },
                onSaved: (value) {
                  context.read<SelectedOrganizationTypeCubit>().change(value);
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
      ),);
  }
}


