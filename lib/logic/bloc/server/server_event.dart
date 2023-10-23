part of 'server_bloc.dart';

abstract class ServerEvent extends Equatable {
  const ServerEvent();
}

final class StartServerCheckEvent extends ServerEvent {

  const StartServerCheckEvent();

  @override
  List<Object?> get props => throw UnimplementedError();

}

final class AvailibleServerEvent extends ServerEvent {

  const AvailibleServerEvent(this._status);
  final bool _status;

  @override
  List<Object?> get props => throw UnimplementedError();

}

