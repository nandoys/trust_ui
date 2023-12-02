enum ApiStatus {succeeded, failed, requesting }

enum ViewMode {grid, list, table }

enum CalculationMode { percent, fix }

/// get protocol from format "[[protocol]] host:port"
String getProtocol(String toSplit) {
  final serverSplit = toSplit.split(' ');
  final protocol = serverSplit[0];
  return protocol.substring(1, serverSplit[0].length-1);
}

/// get server address from format "[[protocol]] host:port" to "host:port"
String getServerAddress(String toSplit) {
  final serverSplit = toSplit.split(' ');
  return serverSplit[1];
}

/// Format from "protocol:host:port"  to "[[protocol]] host:port"
String formatActiveServer(String toSplit) {
  final serverSplit = toSplit.split(':');
  final protocol = serverSplit[0];
  final host = serverSplit[1];
  final port = serverSplit[2];
  return '[$protocol] $host:$port';
}

/// Format from "[[protocol]] host:port" to "protocol:host:port"
String formatServers(String toSplit) {
  final serverSplit = toSplit.split(' ');
  final protocol = getProtocol(toSplit);
  final server = serverSplit[1];
  return '$protocol:$server';
}