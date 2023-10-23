import 'package:http/http.dart' as http;

class Server {
  Server();

  bool? hasError;
  
  Stream<bool> status() async* {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.http('127.0.0.1:8000', 'api/'),
      );

      if (response.statusCode == 200) {
        hasError = false;
        yield true;
      } else {
        hasError = true;
        yield false;
      }
    } on http.ClientException {
      hasError = true;
    } finally {
      if(hasError == true) {
        yield false;
      }
    }


  }
}