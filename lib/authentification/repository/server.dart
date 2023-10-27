import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Server {
  Server();

  Future<bool> status(String address) async {
    var client = http.Client();

    var response = await client.get(
      Uri.http(address, 'api/'),
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception('erreur serveur');
  }

  Future<Map> getServers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? addresses = prefs.getStringList('servers');

    String? address = prefs.getString('server');

    return {'current': address, 'all': addresses};
  }

  Future<Map> addServer(String server) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList('servers') != null) {
      List<String> servers = prefs.getStringList('servers') as List<String>;

      if (!servers.contains(server)) {
        servers.add(server);
        prefs.setStringList('servers', servers);
        prefs.setString('server', server);
        return {'current': server, 'all': servers};
      }

      return {'current': prefs.getString('server'), 'all': servers};

    } else {
      prefs.setStringList('servers', [server]);
      prefs.setString('server', server);

      return {'current': server, 'all': [server]};
    }
  }

  Future<String> activateServer(String server) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('server', server);
    return server;
  }

  Future<Map> updateServer(String oldAddress, String newAddress) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> servers = prefs.getStringList('servers') as List<String>;

    String? current = prefs.getString('server') == oldAddress ? newAddress : prefs.getString('server');

    servers[servers.indexOf(oldAddress)] = newAddress;

    prefs.setStringList('servers', servers);

    if (current != null) {
      prefs.setString('server', current);
    }

    return {'current': current, 'all': servers };
  }

  Future<Map> removeServer(String address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? servers = prefs.getStringList('servers');

    servers?.remove(address);

    prefs.setStringList('servers', servers!);

    String? current = prefs.getString('server');

    if(current == address) {
      prefs.remove('server');
    }

    return {'current': prefs.getString('server'), 'all': servers};
  }
}
