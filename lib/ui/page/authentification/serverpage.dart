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
  late String _serverPort;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  SizedBox(
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
                    if(state is ServerAdding) {
                      SnackBar notif;
                      if (state.adding) {
                        notif = const SnackBar(content: Text('Serveur ajouté avec succès! Attendez on procède à la connexion...'),
                          backgroundColor: Colors.green,);
                        ScaffoldMessenger.of(context).showSnackBar(notif);
                        Navigator.of(context).pop();
                      } else {
                        notif = const SnackBar(
                          content: Text('Ce serveur existe déjà'), backgroundColor: Color.fromRGBO(255, 0, 0, 1),);
                        ScaffoldMessenger.of(context).showSnackBar(notif);
                      }
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Nouveau Serveur', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: TextFormField(
                                autofocus: true,
                                decoration: const InputDecoration(
                                    filled: true,
                                    isDense: true,
                                    labelText: 'Adresse IP ou nom de domaine'
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Veuillez entrer l'adresse du serveur";
                                  }

                                  if (int.tryParse(value) != null) {
                                    return "Adresse incorrecte";
                                  }

                                  return null;
                                },
                                onSaved: (value) { _serverHost = value as String; },
                              ),
                            ),
                            Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "Port réquis";
                                      }

                                      if(int.tryParse(value) == null){
                                        return "Port invalide";
                                      }

                                      return null;
                                    },
                                    onSaved: (value) { _serverPort = value as String; },
                                    decoration: const InputDecoration(
                                        filled: true,
                                        isDense: true,
                                        labelText: 'Port*'
                                    ),
                                  ),
                                )
                            )
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
                          ],),
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

      if (servers.contains(address)) {
        // Le serveur existe déjà
        serverBloc.add(ServerAddedEvent(address: address, isSuccessful: false));
      } else {
        servers.add('$_serverHost:$_serverPort');
        prefs.setStringList('servers', servers);
        serverBloc.add(ServerAddedEvent(address: address, isSuccessful: true));
      }
    } else {
      String address = '$_serverHost:$_serverPort';
      prefs.setStringList('servers', [address]);
      serverBloc.add(ServerAddedEvent(address: address, isSuccessful: true));
    }
  }
}
