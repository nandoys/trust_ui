import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_app/organisation//bloc/server/server_bloc.dart';

import 'package:trust_app/organisation//ui/view/server_form.dart';

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
      backgroundColor: Colors.white60.withOpacity(0.4),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.26,
          height: MediaQuery.of(context).size.height * 0.65,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0)
            ),
            child: BlocProvider.value(
              value: context.read<ServerBloc>(),
              child: ServerForm(defaultHost: widget.host, defaultPort: widget.port,),
            ),
          ),
        ),
      ),
    );
  }
}
