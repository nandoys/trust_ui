import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:native_context_menu/native_context_menu.dart';
import 'package:trust_app/logic/bloc/server/server.dart';
import 'package:trust_app/logic/bloc/server/server_bloc.dart';


Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _obscurText = true;
  String _selectedOrganisation = 'Aucun';
  static final _serverBloc = ServerBloc(server: Server());
  static const availibleServer = StartServerCheckEvent();

  @override
  Widget build(BuildContext context) {

    //context.<ServerBloc>read().

    Timer.periodic(const Duration(seconds: 5), (timer) {
      _serverBloc.add(availibleServer);
    });

    return BlocProvider(
      create: (context) => _serverBloc,
      child: Scaffold(
          body: Center(
            child:  SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.65,
              child: Card(
                color: Colors.white.withOpacity(1),
                elevation: 3,
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Connexion'),
                      BlocListener<ServerBloc, ServerState>(
                        listener: (context, state) {
                          //print(state.isRunning);
                          if(state is ServerIsNotRunning) {
                            SnackBar notif = const SnackBar(
                              content: Text('Not running...'), backgroundColor: Color.fromRGBO(255, 0, 0, 1),);
                            ScaffoldMessenger.of(context).showSnackBar(notif);
                          }
                          if(state is ServerIsRunning) {
                            SnackBar notif = const SnackBar(content: Text('Running...'),
                            backgroundColor: Colors.green,);
                            ScaffoldMessenger.of(context).showSnackBar(notif);
                          }
                      }, child: const Text(''),),
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
                      }),
                      menuItems: [
                        MenuItem(title: 'Nouvelle', action: 'create'),
                        MenuItem(title: 'La Borne'),
                        MenuItem(title: 'Trust'),
                      ],
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
                          _selectedOrganisation = item.title;
                        }
                      }),
                      menuItems: [
                        MenuItem(title: 'Nouvelle', action: 'create'),
                        MenuItem(title: 'La Borne'),
                        MenuItem(title: 'Trust'),
                      ],
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
                ],
              ),
            ),
          ),
        ),
    );
  }

}
