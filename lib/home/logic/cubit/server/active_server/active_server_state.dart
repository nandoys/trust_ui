part of 'active_server_cubit.dart';

@immutable
abstract class ActiveServerState {
  const ActiveServerState({this.protocol, this.host, this.port, this.fullAddress});
  final String? protocol;
  final String? host;
  final int? port;
  final String? fullAddress;
}

class ActiveServerInitial extends ActiveServerState {}

class ActiveServerSelected extends ActiveServerState {
  const ActiveServerSelected({required super.protocol, required super.host, required super.port,
    required super.fullAddress});

}