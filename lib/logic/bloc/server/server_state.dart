part of 'server_bloc.dart';

enum ServerStatus {initial, success, failure, empty}


final class ServerState extends Equatable {
  const ServerState({this.status = ServerStatus.initial, this.servers, this.current});

  final ServerStatus status;
  final String? current;
  final List<String>? servers;

  ServerState copyWith({ServerStatus? status, String? current, List<String>? servers}) {
    return ServerState(
      status: status ?? this.status,
      current: current ?? this.current,
      servers: servers ?? this.servers
    );
  }

  @override
  List<Object?> get props => [status, current, servers];
}
