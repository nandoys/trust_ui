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

  Future<List<String>?> getServers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? addresses = prefs.getStringList('servers');

    return addresses;
  }

  Future<String?> getCurrentServer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? address = prefs.getString('server');

    return address;
  }

  Future removeServer(String address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? addresses = prefs.getStringList('servers');

    addresses?.remove(address);

    prefs.setStringList('servers', addresses!);

    String? selectedServer = prefs.getString('server');

    if(selectedServer == address) {
      prefs.remove('server');
    }

    return addresses;
  }
}
