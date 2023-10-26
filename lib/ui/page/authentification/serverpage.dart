import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trust_app/logic/bloc/server/server_bloc.dart';

import 'package:trust_app/logic/bloc/server/server.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({super.key});

  @override
  State<ServerPage> createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  late String _serverHost;
  String? _serverPort;
  final _formKey = GlobalKey<FormState>();
  final _portController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.26,
          height: MediaQuery.of(context).size.height * 0.65,
          child: Card(
            elevation: 3,
            child: Scaffold(
              appBar: AppBar(),
              body: Form(
                key: _formKey,
                child: BlocListener<ServerBloc, ServerState>(
                  listener: (context, state) {
                    if (state.status == ServerStatus.success) {
                        Navigator.of(context).pop();
                    }
                    else if (state.status == ServerStatus.empty) {
                      SnackBar notif = const SnackBar(
                        width: 450.0,
                        behavior: SnackBarBehavior.floating,
                        showCloseIcon: true,
                        content: Text(
                          "Le serveur existe déjà!!!",
                          textAlign: TextAlign.center,),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(notif);
                    }

                    else if (state.status == ServerStatus.failure) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Nouveau Serveur',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
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
                                    decoration: const InputDecoration(
                                        filled: true,
                                        isDense: true,
                                        labelText: 'Adresse IP ou nom de domaine*'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Veuillez entrer l'adresse du serveur";
                                      }

                                      if (state.servers!.contains('$value:${_portController.text}')) {
                                        return "Ce serveur existe déjà!";
                                      }

                                      if (int.tryParse(value) != null) {
                                        return "Adresse incorrecte";
                                      }

                                      return null;
                                    },
                                    onSaved: (value) {
                                      _serverHost = value as String;
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
                                    return "Port réquis";
                                  }

                                  if (int.tryParse(value) == null) {
                                    return "Port invalide";
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  _serverPort = value as String;
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
                            TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  addServer(context);
                                }
                              },
                              child: const Text('Se connecter'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addServer(BuildContext _) async {
    final serverBloc = BlocProvider.of<ServerBloc>(_);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList('servers') != null) {
      List<String> servers = prefs.getStringList('servers') as List<String>;

      String address = '$_serverHost:$_serverPort';

      if (!servers.contains(address)) {
        servers.add('$_serverHost:$_serverPort');
        prefs.setStringList('servers', servers);
        serverBloc.add(ServerAddedEvent(current: address, servers: servers));
        prefs.setString('server', address);
      }

    } else {
      String address = '$_serverHost:$_serverPort';
      prefs.setStringList('servers', [address]);
      prefs.setString('server', address);
      serverBloc.add(ServerAddedEvent(current: address, servers: [address]));
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
