part of 'server_bloc.dart';


enum ServerStatus {initial, success, failure, empty, removed}


final class ServerState extends Equatable {
  const ServerState({this.status = ServerStatus.initial, this.servers, this.current, this.contextMenu, this.isUpdating});

  final ServerStatus status;
  final String? current;
  final List<String>? servers;
  final List<MenuItem>? contextMenu;
  final bool? isUpdating;

  ServerState copyWith({ServerStatus? status, String? current, List<String>? servers, bool? isUpdating}) {
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
        contextMenu: contextMenu,
        isUpdating: isUpdating
    );
  }

  @override
  List<Object?> get props => [status, current, servers, isUpdating];
}