import 'dart:math';

import 'package:breathing_collection/breathing_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trust_app/logic/bloc/server/server.dart';
import 'package:trust_app/logic/bloc/server/server_bloc.dart';
import 'package:trust_app/ui/page/authentification/signup.dart';
import 'package:trust_app/ui/page/authentification/serverpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _obscurText = true;
  String _selectedOrganisation = 'Aucun';
  List<MenuItem> organisationMenu = [MenuItem(title: 'Nouvelle', action: 'create')];
  List<MenuItem> serverMenu = [MenuItem(title: 'Nouveau', action: 'create')];
  final ServerBloc _serverBloc = ServerBloc(server: Server());

  @override
  Widget build(BuildContext context) {
    //getServer();
    return BlocProvider(
      create: (context) => _serverBloc,
      child: FutureBuilder(
        future: getServer(),
        builder: (context, response) {
          if (response.connectionState == ConnectionState.done) {
            return Scaffold(
                backgroundColor: Colors.white60.withOpacity(0.4),
                body: Center(
                child:  SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    child: Form(
                      child: BlocListener<ServerBloc, ServerState>(
                        listener: (context, state) {
                          if(state is ServerIsNotRunning) {
                            SnackBar notif = const SnackBar(
                              content: Text("La connexion avec le serveur a échoué, veuillez réessayer"), backgroundColor: Colors.red,);
                            ScaffoldMessenger.of(context).showSnackBar(notif);
                          }
                          if(state is ServerIsRunning) {
                            SnackBar notif = const SnackBar(content: Text("La connexion avec le serveur établie avec succès"),
                              backgroundColor: Colors.green,);
                            ScaffoldMessenger.of(context).showSnackBar(notif);
                          }
                        },
                        listenWhen: (previous, current) {
                          if (previous is ServerAdding) {
                            return previous.adding;
                          }
                          return true;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Connexion'),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                autofocus: true,
                                decoration: const InputDecoration(
                                    filled: true,
                                    isDense: true,
                                    labelText: 'Utilisateur'
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  isDense: true,
                                  labelText: 'Mot de passe',
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscurText = !_obscurText;
                                        });
                                      },
                                      child: Icon(_obscurText ? Icons.visibility : Icons.visibility_off)
                                  ),
                                ),
                                obscureText: _obscurText,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextButton(
                                onPressed: () {
                                  print('pressed');
                                },
                                child: const Text('Se connecter'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
                bottomNavigationBar: BlocBuilder<ServerBloc, ServerState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 27,
                      child: Container(
                        color: Colors.black,
                        child: state.runtimeType != ServerInitializing ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            state.runtimeType == ServerIsRunning ? Row(
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Container(
                                        color: Colors.purple.shade300,
                                        child: Center(
                                          child: Text(_selectedOrganisation[0],
                                              style: const TextStyle(fontWeight: FontWeight.w500,)),
                                        )
                                    )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(_selectedOrganisation, style: const TextStyle(color: Colors.white, fontSize: 12.0),),
                                ),
                              ],
                            ): const Divider(),

                            state.runtimeType == ServerIsRunning ? ContextMenuRegion(
                                onDismissed: () => {},
                                onItemSelected: (item) => setState(() {
                                  if (item.action == null) {
                                    _selectedOrganisation = item.title;
                                  }

                                  if (item.action == 'create') {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage()));
                                  }
                                }),
                                menuItems: organisationMenu,
                                child: TextButton.icon(onPressed: () { print('object'); },
                                  icon: const Icon(Icons.circle),
                                  label: const Text('organisation', style: TextStyle(color: Colors.white, fontSize: 12.0),),
                                  style: ButtonStyle(
                                      iconSize: MaterialStateProperty.resolveWith((states) => 15.0),
                                      iconColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
                                      overlayColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade900)
                                  ),
                                )
                            ): const Divider(thickness: 0.1,),

                            ContextMenuRegion(
                                onDismissed: () => {},
                                onItemSelected: (item) {
                                  if (item.action == 'create') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider.value(
                                                  value: _serverBloc,
                                                  child: const ServerPage(),
                                                )
                                        )
                                    );
                                  }
                                },
                                menuItems: serverMenu,
                                child: FutureBuilder(
                                    future: getServers(),
                                    builder: (context, snapshot) {
                                      return TextButton.icon(
                                        onPressed: () {
                                          print('object');
                                        },
                                        icon: const Icon(Icons.circle),
                                        label: Text(
                                          state.selectedServer != null
                                              ? state
                                              .selectedServer as String
                                              : 'Aucun Serveur',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0),
                                        ),
                                        style: ButtonStyle(
                                            iconSize: MaterialStateProperty
                                                .resolveWith((
                                                states) => 15.0),
                                            iconColor: MaterialStateProperty
                                                .resolveWith(
                                                    (states) {
                                                  if (state.isRunning ==
                                                      true) {
                                                    return Colors.green;
                                                  }
                                                  else
                                                  if (state.isRunning ==
                                                      false) {
                                                    return Colors.red;
                                                  }

                                                  return Colors.blue;
                                                }
                                            ),
                                            overlayColor: MaterialStateProperty
                                                .resolveWith((states) =>
                                            Colors.grey.shade900)
                                        ),
                                      );
                                    })
                            ),
                          ],
                        ): const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                  strokeWidth: 2.0,
                                )
                            ),
                            SizedBox(width: 4.0,),
                            Text('Initialisation serveur...', style: TextStyle(color: Colors.white),),
                            SizedBox(width: 12.0,),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }

          return Scaffold(
            backgroundColor: Colors.white70.withOpacity(0.3),
            body: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                          strokeWidth: 2.0,
                        )
                    ),
                    SizedBox(width: 4.0,),
                    Text('Recherche serveur...', style: TextStyle(color: Colors.white, fontSize: 12.0,
                        decoration: TextDecoration.none),),
                    SizedBox(width: 4.0,),
                  ],
              ),
            ),
          );
        },
      ),
    );
    // return FutureBuilder(
    //   future: getServer(),
    //   builder: (context, response) {
    //     if (response.connectionState == ConnectionState.done) {
    //       String? address = response.data;
    //
    //     }
    //
    //     return const Row(
    //       children: [
    //         SizedBox(
    //             height: 20,
    //             width: 20,
    //             child: CircularProgressIndicator(
    //               color: Colors.blue,
    //               strokeWidth: 2.0,
    //             )
    //         ),
    //         SizedBox(width: 4.0,),
    //         Text('Recherche serveur', style: TextStyle(color: Colors.white, fontSize: 12.0),),
    //         SizedBox(width: 4.0,),
    //       ],
    //     );
    //   },
    // );
  }

  Future getServer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> server = prefs.getString('server').toString().split(':');
    if (server.length != 2) {
      throw IndexError;
    }

    String? address = '${server[0]}:${server[1]}';

    if (prefs.getString('server') != null) {
      StartServerCheckEvent startServerCheck = StartServerCheckEvent(address: address);
      _serverBloc.add(startServerCheck);
    }

    return address;
  }

  Future getServers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? address = prefs.getStringList('servers');

    address?.forEach((item) {
      // -1 enlève le menu nouveau serveur du calcul
      if(serverMenu.length - 1 < address.length) {
        serverMenu.add(MenuItem(
            title: item,
            items: [
              MenuItem(title: 'Activer', action: 'activate'),
              MenuItem(title: 'Modifier', action: 'update'),
              MenuItem(title: 'Supprimer', action: 'delete')
            ]
        ));
      }
    });
  }

  @override
  void dispose() {
    _serverBloc.close();
    super.dispose();
  }
}