import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trust_app/logic/bloc/server/server_bloc.dart';

import 'package:trust_app/logic/bloc/server/server.dart';
import 'package:trust_app/ui/view/server/server_form.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({super.key, this.host, this.port});
  final String? host;
  final String? port;

  @override
  State<ServerPage> createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {


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
              body: BlocProvider.value(
                value: context.read<ServerBloc>(),
                child: ServerForm(defaultHost: widget.host, defaultPort: widget.port,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
