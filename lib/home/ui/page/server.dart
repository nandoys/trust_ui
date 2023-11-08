import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trust_app/home//ui/view/view.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({super.key, this.host, this.port, required this.protocol});
  final String? host;
  final int? port;
  final String? protocol;

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
              value: context.read<ServerContextMenuCubit>(),
              child: ServerForm(defaultHost: widget.host, defaultPort: widget.port,
                protocol: widget.protocol?.replaceFirst(RegExp(r'h'), 'H'),),
            ),
          ),
        ),
      ),
    );
  }
}
