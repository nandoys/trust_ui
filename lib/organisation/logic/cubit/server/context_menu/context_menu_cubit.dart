import 'package:bloc/bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/organisation/data/repository/server_repository.dart';
import 'package:trust_app/organisation/logic/cubit/server/context_server/context_server_cubit.dart';

class ServerContextMenuCubit extends Cubit<List<MenuItem>> {
  ServerContextMenuCubit({required this.serverRepository, required this.contextServer, required this.initial})
      : super(initial);

  final ServerRepository serverRepository;
  final ContextServerCubit contextServer;
  List<MenuItem> initial;

  void getServers() async {
    List<String>? servers = await serverRepository.getServers();

    if (servers != null) {
      List<MenuItem> menus = initial;
      List<MenuItem> serverMenu = servers.map((server) {
        if (contextServer.state != server) {
          return MenuItem(title: server, items: [
            MenuItem(title: 'Activer', action: server),
            MenuItem(title: 'Modifier', action: server),
            MenuItem(title: 'Supprimer', action: server),
          ]);
        } else {
          return MenuItem(title: server, items: [
            MenuItem(title: 'Modifier', action: server),
            MenuItem(title: 'Supprimer', action: server),
          ]);
        }
      }).toList();

      menus.addAll(serverMenu);
      emit(menus);
    }
  }

  void addServer(String server) {
    serverRepository.addServer(server);
    getServers();
  }

  void activateServer(String server) {
    serverRepository.activateServer(server);
    contextServer.getContextServer();
    getServers();
  }

  void updateServer(String oldServer, String newServer) {
    serverRepository.updateServer(oldServer, newServer);
    getServers();
    if (oldServer == contextServer.state) {
      contextServer.getContextServer();
    }
  }

  void removeServer(String server) {
    serverRepository.removeServer(server);
    getServers();
    contextServer.getContextServer();
  }
}
