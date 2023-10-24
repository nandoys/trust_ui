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
  String _selectedServer = 'Aucun serveur';
  static final _serverBloc = ServerBloc(server: Server());
  List<MenuItem> organisationMenu = [MenuItem(title: 'Nouvelle', action: 'create')];
  List<MenuItem> serverMenu = [MenuItem(title: 'Nouveau', action: 'create')];


  @override
  Widget build(BuildContext context) {
    getServer();
    return BlocProvider(
      create: (context) => _serverBloc,
      child: Scaffold(backgroundColor: Colors.white60.withOpacity(0.3),
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
        bottomNavigationBar: SizedBox(
          height: 27,
          child: Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                const SizedBox(width: 4.0,),
                Text(_selectedOrganisation, style: const TextStyle(color: Colors.white, fontSize: 12.0),),
                const SizedBox(width: 20.0,),
                ContextMenuRegion(
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
                ),
                const SizedBox(width: 10.0,),
                ContextMenuRegion(
                    onDismissed: () => {},
                    onItemSelected: (item) => setState(() {
                      if (item.action == null) {
                        _selectedServer = item.title;
                      }

                      if (item.action == 'create') {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: _serverBloc,
                                  child: const ServerPage(),
                                )
                            )
                        );
                      }
                    }),
                    menuItems: serverMenu,
                    child: BlocBuilder<ServerBloc, ServerState>(builder: (context, state){
                      return TextButton.icon(
                        onPressed: () { print('object'); },
                        icon: const Icon(Icons.circle),
                        label: Text(_selectedServer, style: const TextStyle(color: Colors.white, fontSize: 12.0),),
                        style: ButtonStyle(
                            iconSize: MaterialStateProperty.resolveWith((states) => 15.0),
                            iconColor: MaterialStateProperty.resolveWith(
                                    (states) {
                                  if (state.isRunning == true) {
                                    return Colors.green;
                                  }
                                  else if (state.isRunning == false) {
                                    return Colors.red;
                                  }

                                  return Colors.blue;
                                }
                            ),
                            overlayColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade900)
                        ),
                      );
                    })
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getServer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString('server', '127.0.0.1:8000');

    List<String> address = prefs.get('server').toString().split(':');
    if (address.length != 2) {
      throw IndexError;
    }

    String host = address[0];
    String port = address[1];

    if (prefs.get('server') != null) {
      StartServerCheckEvent availibleServer = StartServerCheckEvent(host: host, port: port);
      _serverBloc.add(availibleServer);
    }
  }

  @override
  void dispose() {
    _serverBloc.close();
    super.dispose();
  }
}