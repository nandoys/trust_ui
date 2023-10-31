import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trust_app/organisation/logic/cubit/server/connectivity/connectivity_status_cubit.dart';

class ServerRepository {
  ServerRepository();

  Stream<ConnectivityStatus> status(String address) async* {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.http(address, 'api/'),
      );

      if (response.statusCode == 200) {
        yield ConnectivityStatus.connected;
      } else {
        yield ConnectivityStatus.disconnected;
      }

    } on http.ClientException {
      yield ConnectivityStatus.disconnected;
    }

  }

  Future<List<String>?> getServers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? addresses = prefs.getStringList('servers');
    return addresses;
  }

  Future<String?> getContextServer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? address = prefs.getString('server');
    return address;
  }

  Future<void> addServer(String server) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList('servers') != null) {
      List<String> servers = prefs.getStringList('servers') as List<String>;

      if (!servers.contains(server)) {
        servers.add(server);
        prefs.setStringList('servers', servers);
      }
    } else {
      prefs.setStringList('servers', [server]);
    }
  }

  Future<void> activateServer(String server) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('server', server);
  }

  Future<void> updateServer(String oldServer, String newServer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> servers = prefs.getStringList('servers') as List<String>;

    String? current = prefs.getString('server') == oldServer ? newServer : prefs.getString('server');

    if(servers.contains(oldServer)) {
      servers[servers.indexOf(oldServer)] = newServer;
    }

    prefs.setStringList('servers', servers);

    if (current != null) {
      prefs.setString('server', current);
    }
  }

  Future<void> removeServer(String server) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? servers = prefs.getStringList('servers');

    servers?.remove(server);

    prefs.setStringList('servers', servers!);

    if(prefs.getString('server') == server) {
      prefs.remove('server');
    }
  }
}
