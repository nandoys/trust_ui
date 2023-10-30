part of 'server_bloc.dart';

abstract class ServerEvent extends Equatable {
  const ServerEvent({this.current, this.servers});

  final String? current;
  final List<String>? servers;
}

final class AppStartedEvent extends ServerEvent {

  const AppStartedEvent();

  @override
  List<Object?> get props => [];

}

final class ServerCheckEvent extends ServerEvent {

  const ServerCheckEvent({required current, required servers}) :
        super(current: current, servers: servers);

  @override
  List<Object?> get props => [current, servers];

}

final class ServerAtivateEvent extends ServerEvent {
  const ServerAtivateEvent({required current}) : super(current: current);

  @override
  List<Object?> get props => [];

}

final class ServerAddEvent extends ServerEvent {
  const ServerAddEvent({required this.addValue});

  final String addValue;

  @override
  List<Object?> get props => [current, servers];

}

final class ServerUpdateEvent extends ServerEvent {
  const ServerUpdateEvent({required this.oldValue, required this.newValue});

  final String oldValue;
  final String newValue;

  @override
  List<Object?> get props => [current, servers];

}

final class ServerRemoveEvent extends ServerEvent {

  const ServerRemoveEvent({required this.deleteServer});

  final String deleteServer;


  @override
  List<Object?> get props => [deleteServer];

}
