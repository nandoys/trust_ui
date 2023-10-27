part of 'server_bloc.dart';


enum ServerStatus {initial, success, failure, empty, removed, updated}


final class ServerState extends Equatable {
  const ServerState({this.status = ServerStatus.initial, this.servers, this.current, this.contextMenu});

  final ServerStatus status;
  final String? current;
  final List<String>? servers;
  final List<MenuItem>? contextMenu;

  ServerState copyWith({ServerStatus? status, String? current, List<String>? servers}) {
    List<MenuItem> contextMenu = [MenuItem(title: 'Nouveau', action: 'create')];

    servers?.forEach((server) {
      contextMenu.add(
          MenuItem(
              title: server,
              items: current != server ? [
                MenuItem(title: 'Activer', action: server),
                MenuItem(title: 'Modifier', action: server),
                MenuItem(title: 'Supprimer', action: server),
              ] : [
                MenuItem(title: 'Modifier', action: server),
                MenuItem(title: 'Supprimer', action: server)
              ]
          )
      );
    });

    return ServerState(
        status: status ?? this.status,
        current: current,
        servers: servers,
        contextMenu: contextMenu
    );
  }

  @override
  List<Object?> get props => [status, current, servers];
}