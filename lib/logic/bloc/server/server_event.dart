part of 'server_bloc.dart';

abstract class ServerEvent extends Equatable {
  const ServerEvent();
}

final class StartServerCheckEvent extends ServerEvent {

  const StartServerCheckEvent({required this.address});
  final String address;

  @override
  List<Object?> get props => throw UnimplementedError();

}

final class AvailibleServerEvent extends ServerEvent {

  const AvailibleServerEvent(this._status, this.address);
  final bool _status;
  final String address;

  @override
  List<Object?> get props => throw UnimplementedError();

}

final class ServerChangedEvent extends ServerEvent {
  const ServerChangedEvent();

  @override
  List<Object?> get props => throw UnimplementedError();

}

final class ServerAddedEvent extends ServerEvent {
  const ServerAddedEvent({required this.address, required this.isSuccessful});
  final String address;
  final bool isSuccessful;

  @override
  List<Object?> get props => throw UnimplementedError();

}