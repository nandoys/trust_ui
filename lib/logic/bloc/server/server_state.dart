part of 'server_bloc.dart';

abstract class ServerState extends Equatable {
  const ServerState({required this.isRunning});
  final bool? isRunning;
}

class ServerInitializing extends ServerState {
  const ServerInitializing() : super(isRunning: null);

  @override
  List<Object> get props => [];
}

class ServerIsRunning extends ServerState {
  const ServerIsRunning() : super(isRunning: true);

  @override
  List<Object> get props => [];
}

class ServerIsNotRunning extends ServerState {
  const ServerIsNotRunning() : super(isRunning: false);

  @override
  List<Object> get props => [];
}

class ServerAdding extends ServerState {
  const ServerAdding({required this.adding}) : super(isRunning: false);

  final bool adding;

  @override
  List<Object> get props => [];
}