import 'package:bloc/bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:server_api/src/data/data.dart';
import 'package:server_api/src/domain/domain.dart';

import 'package:utils/utils.dart';

class ServerContextMenuCubit extends Cubit<List<MenuItem>> {
  ServerContextMenuCubit({required this.repository, required this.activeServer, required this.initial})
      : super(initial);

  final ServerRepository repository;
  final ActiveServerCubit activeServer;
  final List<MenuItem> initial;

  void getServers() async {
    List<String>? servers = await repository.getServers();

    if (servers != null) {
      List<MenuItem> menus = [
        MenuItem(title: 'Nouveau (Http)', action: 'create http'),
        MenuItem(title: 'Nouveau (Https)', action: 'create https')
      ];
      List<MenuItem> serverMenu = servers.map((server) {
        if (activeServer.state.fullAddress != server) {
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
    repository.addServer(server);
    getServers();
  }

  void activateServer(String server) {
    repository.activateServer(server);
    activeServer.get();
    getServers();
  }

  void updateServer(String oldServer, String newServer) {
    repository.updateServer(oldServer, newServer);
    getServers();
    if (formatActiveServer(oldServer) == activeServer.state.fullAddress) {
      activeServer.get();
    }
  }

  void removeServer(String server) {
    repository.removeServer(formatServers(server));
    getServers();
    if (server == activeServer.state.fullAddress) {
      activeServer.get();
    }
  }
}
