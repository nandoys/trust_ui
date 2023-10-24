part of 'server_bloc.dart';

abstract class ServerEvent extends Equatable {
  const ServerEvent();
}

final class StartServerCheckEvent extends ServerEvent {

  const StartServerCheckEvent({required this.host, required this.port});
  final String host;
  final String port;

  @override
  List<Object?> get props => throw UnimplementedError();

}

final class AvailibleServerEvent extends ServerEvent {

  const AvailibleServerEvent(this._status);
  final bool _status;

  @override
  List<Object?> get props => throw UnimplementedError();

}

final class ServerChangedEvent extends ServerEvent {
  const ServerChangedEvent();

  @override
  List<Object?> get props => throw UnimplementedError();

}

final class ServerAddedEvent extends ServerEvent {
  const ServerAddedEvent({required this.host, required this.port, required this.isSuccessful});
  final String host;
  final String port;
  final bool isSuccessful;

  @override
  List<Object?> get props => throw UnimplementedError();

}