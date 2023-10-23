import 'package:http/http.dart' as http;

class Server {
  Server();

  bool? hasError;

  Stream<Future<bool>> status() {
    var client = http.Client();

    Future<bool> request() async {

      try {
        var response = await client.get(
          Uri.http('127.0.0.1:8000', 'api/'),
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

    final stream =  Stream.periodic(const Duration(seconds: 5), (computationCount) {
       return request();
    },);

    return stream;

  }
}