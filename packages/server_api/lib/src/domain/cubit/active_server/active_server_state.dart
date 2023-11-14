part of 'active_server_cubit.dart';

@immutable
abstract class ActiveServerState extends Equatable {
  const ActiveServerState({this.protocol, this.host, this.port, this.fullAddress});
  final String? protocol;
  final String? host;
  final int? port;
  final String? fullAddress;
}

class ActiveServerInitial extends ActiveServerState {
  @override
  List<Object?> get props => [fullAddress];
}

class ActiveServerSelected extends ActiveServerState {
  const ActiveServerSelected({required super.protocol, required super.host, required super.port,
    required super.fullAddress});

  @override
  List<Object?> get props => [fullAddress];

}