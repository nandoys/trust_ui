import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trust_app/home/logic/cubit/cubit.dart';

import 'package:trust_app/utils.dart';

class ServerRepository {
  ServerRepository();

  Stream<ConnectivityStatus> status(String server) async* {
    var client = http.Client();

    try {
      final protocol = getProtocol(server);
      var response = await client.get(
        protocol == 'Http' ? Uri.http(getServerAddress(server), 'api/') : Uri.https(getServerAddress(server), 'api/'),
      );

      if (response.statusCode == 200) {
        yield ConnectivityStatus.connected;
      } else {
        yield ConnectivityStatus.disconnected;
      }
    } catch (e) {
      yield ConnectivityStatus.disconnected;
    }

  }

  Future<List<String>?> getServers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? addresses = prefs.getStringList('servers');

    return addresses?.map((address) => formatActiveServer(address)).toList();
  }

  Future<String?> getActiveServer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? address = prefs.getString('server');
    List<String>? servers = prefs.getStringList('servers');
    if (address != null) {
      if (servers != null && servers.contains(formatServers(address))) {
        return address;
      }
    }

    return null;
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

    final oldFormated = formatActiveServer(oldServer);
    final newFormated = formatActiveServer(newServer);

    String? current = prefs.getString('server') == oldFormated ? newFormated : prefs.getString('server');

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

    print(server);

    servers?.remove(server);

    prefs.setStringList('servers', servers!);

    final activeServer = prefs.getString('server');

    if(activeServer!= null && formatServers(activeServer) == server) {
      prefs.remove('server');
    }
  }
}
