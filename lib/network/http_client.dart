final class HttpClient {
  HttpClient({required this.host, required this.headers});

  final String host;
  Map<String, String> headers;

  HttpClient.token({String? token}) : host = 'run.mocky.io', headers = {'token': ?token};

  void setToken(String? token) {
    if (token is String) {
      headers['token'] = token;
    } else {
      headers.remove('token');
    }
  }

  Future<void> req() async {
    print('do req: $headers');
  }
}
