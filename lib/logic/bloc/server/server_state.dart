part of 'server_bloc.dart';

abstract class ServerState extends Equatable {
  const ServerState({required this.isRunning, this.selectedServer});
  final bool? isRunning;
  final String? selectedServer;
}

class ServerInitializing extends ServerState {
  const ServerInitializing() : super(isRunning: null);

  @override
  List<Object?> get props => [];
}

class ServerIsRunning extends ServerState {
   const ServerIsRunning(this.address) : super(isRunning: true, selectedServer: address);

  final String address;

  @override
  List<Object?> get props => [address];
}

class ServerIsNotRunning extends ServerState {
  const ServerIsNotRunning(this.address) : super(isRunning: false, selectedServer: address);

  final String address;

  @override
  List<Object?> get props => [address];
}

class ServerAdding extends ServerState {
  const ServerAdding({required this.adding}) : super(isRunning: false);

  final bool adding;

  @override
  List<Object> get props => [adding];
}