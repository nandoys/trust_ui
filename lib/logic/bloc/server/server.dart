import 'package:http/http.dart' as http;

class Server {
  Server();

  bool? hasError;

  Stream<Future<bool>> status({required String host, required String port}) {
    var client = http.Client();

    Future<bool> request() async {
      String address = '${host.trim()}:${port.trim()}';
      try {
        var response = await client.get(
          Uri.http(address, 'api/'),
        );

        if (response.statusCode == 200) {
          hasError = false;
          return true;
        } else {
          hasError = true;
          return false;
        }
      } on http.ClientException {
        hasError = true;
      }

      return false;
    }

    return Stream.periodic(const Duration(seconds: 5), (computationCount) => request());
  }
}