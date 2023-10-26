part of 'server_bloc.dart';

abstract class ServerEvent extends Equatable {
  const ServerEvent({required this.current, this.servers});

  final String? current;
  final List<String>? servers;
}

final class StartServerCheckEvent extends ServerEvent {

  const StartServerCheckEvent({required current, required servers}) : super(current: current, servers: servers);

  @override
  List<Object?> get props => [current, servers];

}

final class ServerAtivatedEvent extends ServerEvent {
  const ServerAtivatedEvent({required servers, required current}) : super(current: current, servers: servers);

  @override
  List<Object?> get props => throw UnimplementedError();

}

final class ServerAddedEvent extends ServerEvent {
  const ServerAddedEvent({required current, required servers}) :
  super(current: current, servers: servers);

  @override
  List<Object?> get props => [current, servers];

}

final class ServerRemovedEvent extends ServerEvent {
  const ServerRemovedEvent({required addressToDel, required current}) : super(current: current);

  @override
  List<Object?> get props => throw UnimplementedError();

}