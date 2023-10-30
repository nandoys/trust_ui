import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_app/organisation/logic/bloc/server/server_bloc.dart';
import 'package:trust_app/organisation//ui/widget/floating_snack_bar.dart';

class ServerForm extends StatelessWidget {
  ServerForm({super.key, this.defaultHost, this.defaultPort});
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController();
  final _portController = TextEditingController();
  final String? defaultHost;
  final String? defaultPort;

  @override
  Widget build(BuildContext context) {
    if (defaultHost != null) {
      _hostController.text = defaultHost as String;
    }
    if (defaultPort != null) {
      _portController.text = defaultPort as String;
    }

    final ServerBloc serverBloc = context.read<ServerBloc>();

    return Form(
      key: _formKey,
      child: BlocListener<ServerBloc, ServerState>(
        listener: (context, state) {

          if (state.status == ServerStatus.success) {
            Navigator.of(context).pop();
          }

          else if (state.isUpdating == true) {

            SnackBar notif = FloatingSnackBar(
              color: Colors.blueAccent,
              message: "Le serveur a été modifié avec succès",
              messageDuration: const Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(notif);
            Navigator.of(context).pop();
          }

          else if (state.status == ServerStatus.failure) {
            Navigator.of(context).pop();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AppBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                )
            ),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(
                  defaultHost == defaultPort ? 'Nouveau Serveur' : 'Modifier Serveur',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: BlocBuilder<ServerBloc, ServerState>(
                          builder: (context, state) {
                            return TextFormField(
                              autofocus: true,
                              controller: _hostController,
                              decoration: const InputDecoration(
                                  filled: true,
                                  isDense: true,
                                  labelText: 'Adresse IP ou nom de domaine*'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Veuillez entrer l'adresse du serveur";
                                }

                                String oldAddress = '$defaultHost:$defaultPort';
                                String newAddress = '${_hostController.text}:${_portController.text}';

                                if (state.servers!.contains('$value:${_portController.text}')
                                    && oldAddress != newAddress ) {
                                  return "Ce serveur existe déjà!";
                                }

                                if (int.tryParse(value) != null) {
                                  return "Adresse incorrecte";
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _hostController.text = value as String;
                              },
                            );
                          },
                        ),
                      ),
                      Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _portController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "réquis";
                                }

                                if (int.tryParse(value) == null) {
                                  return "invalide";
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _portController.text = value as String;
                              },
                              decoration: const InputDecoration(
                                  filled: true,
                                  isDense: true,
                                  labelText: 'Port*'),
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<ServerBloc, ServerState>(
                          builder: (context, state) =>
                          serverBloc.state.status == ServerStatus.initial ||
                              serverBloc.state.isUpdating == true ?
                          const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ) :
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                String editedAddress = '${_hostController.text}:${_portController.text}';
                                String defaultAddress = '$defaultHost:$defaultPort';

                                SnackBar notif = FloatingSnackBar(
                                  color: Colors.black.withOpacity(0.75),
                                  message: "Il n'y a aucune modification à éffectuer!!!",
                                  messageDuration: const Duration(seconds: 2),
                                );

                                defaultHost == defaultPort ? serverBloc.add(
                                    ServerAddEvent(addValue: editedAddress)
                                ) : defaultAddress == editedAddress ? ScaffoldMessenger.of(context).showSnackBar(notif)
                                    : serverBloc.add(
                                    ServerUpdateEvent(
                                        newValue: editedAddress,
                                        oldValue: defaultAddress
                                    )
                                );
                              }
                            },
                            child: Text(defaultHost == defaultPort ? 'Se connecter' : 'Modifier'),
                          )
                      ),
                    ],
                  ),
                ),
              ],
                )
            )
          ],
        ),
      ),
    );
  }
}
