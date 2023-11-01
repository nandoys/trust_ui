import 'package:bloc/bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/home/data/repository/server_repository.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

import 'package:trust_app/utils.dart';

class ServerContextMenuCubit extends Cubit<List<MenuItem>> {
  ServerContextMenuCubit({required this.serverRepository, required this.activeServer, required this.initial})
      : super(initial);

  final ServerRepository serverRepository;
  final ActiveServerCubit activeServer;
  final List<MenuItem> initial;

  void getServers() async {
    List<String>? servers = await serverRepository.getServers();

    if (servers != null) {
      List<MenuItem> menus = [
        MenuItem(title: 'Nouveau (Http)', action: 'create http'),
        MenuItem(title: 'Nouveau (Https)', action: 'create https')
      ];
      List<MenuItem> serverMenu = servers.map((server) {
        if (activeServer.state != server) {
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
    activeServer.get();
    getServers();
  }

  void updateServer(String oldServer, String newServer) {
    serverRepository.updateServer(oldServer, newServer);
    getServers();
    if (formatActiveServer(oldServer) == activeServer.state) {
      activeServer.get();
    }
  }

  void removeServer(String server) {
    serverRepository.removeServer(formatServers(server));
    getServers();
    if (server == activeServer.state) {
      activeServer.get();
    }
  }
}
