import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:server_api/server_api.dart';
import 'package:trust_app/home//ui/widget/widget.dart';


class ServerForm extends StatefulWidget {
  ServerForm({super.key, this.defaultHost, this.defaultPort, required this.protocol});
  final String? defaultHost;
  final int? defaultPort;
  final String? protocol;

  @override
  State<ServerForm> createState() => _ServerFormState();
}

class _ServerFormState extends State<ServerForm> {
  final _formKey = GlobalKey<FormState>();

  final _hostController = TextEditingController();

  final _portController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.defaultHost != null) {
      _hostController.text = widget.defaultHost.toString();
    }
    if (widget.defaultPort != null) {
      _portController.text = widget.defaultPort.toString();
    }

    final ServerContextMenuCubit serverMenuCubit = context.read<ServerContextMenuCubit>();

    return Form(
      key: _formKey,
      child: BlocListener<ServerContextMenuCubit, List<MenuItem>?>(
        listener: (context, state) {},
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
                  widget.defaultHost == widget.defaultPort ? 'Nouveau Serveur ${widget.protocol}' : 'Modifier Serveur ${widget.protocol}',
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
                        child: BlocBuilder<ServerContextMenuCubit, List<MenuItem>?>(
                          builder: (context, menus) {
                            return TextFormField(
                              autofocus: true,
                              controller: _hostController,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                  filled: true,
                                  isDense: true,
                                  labelText: 'Adresse IP ou nom de domaine*'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Veuillez entrer l'adresse du serveur";
                                }

                                String oldAddress = '${widget.defaultHost}:${widget.defaultPort}';
                                String newAddress = '${_hostController.text}:${_portController.text}';

                                bool serverExist = false;
                                menus?.forEach((menu) {
                                  if (menu.title == '[${widget.protocol}] $value:${_portController.text}'
                                      && oldAddress != newAddress ) {
                                    serverExist = true;
                                  }
                                });

                                if (serverExist) {
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
                                  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            String editedAddress = '${widget.protocol}:${_hostController.text}:${_portController.text}';
                            String defaultAddress = '${widget.protocol}:${widget.defaultHost}:${widget.defaultPort}';

                            SnackBar notif = FloatingSnackBar(
                              color: Colors.black.withOpacity(0.75),
                              message: "Il n'y a aucune modification à éffectuer!!!",
                              messageDuration: const Duration(seconds: 2),
                            );

                            if (widget.defaultHost == widget.defaultPort) {
                              serverMenuCubit.addServer(editedAddress);
                              context.pop();
                            } else {
                              if (defaultAddress == editedAddress) {
                                ScaffoldMessenger.of(context).showSnackBar(notif);
                              } else {
                                serverMenuCubit.updateServer(defaultAddress, editedAddress);
                                context.pop();
                              }
                            }
                          }
                        },
                        child: Text(widget.defaultHost == widget.defaultPort ? 'Ajouter' : 'Modifier'),
                      )
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

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _hostController.dispose();
    _portController.dispose();
    super.dispose();
  }
}
