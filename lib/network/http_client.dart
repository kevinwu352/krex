import 'package:http/http.dart' as http;
import 'endpoint.dart';

abstract class Networkable {
  Future<http.Response> req(Endpoint api);
}

final class HttpClient implements Networkable {
  HttpClient({required this.host, required this.headers});

  final String host;
  final Map<String, String> headers;

  HttpClient.token(String? token) : host = 'dummyjson.com', headers = {'token': ?token};
  // HttpClient.token(String? token) : host = 'www.testingmcafeesites.com', headers = {'token': ?token};

  void setToken(String? token) {
    if (token is String) {
      headers['token'] = token;
    } else {
      headers.remove('token');
    }
  }

  @override
  Future<http.Response> req(Endpoint api) async {
    switch (api.method) {
      case ReqMethod.get:
        final uri = Uri(scheme: 'https', host: host, path: api.path, queryParameters: api.query());
        final response = await http.get(uri, headers: api.heads(headers));
        return response;
      case ReqMethod.post:
        final uri = Uri(scheme: 'https', host: host, path: api.path);
        final response = await http.post(uri, headers: api.heads(headers), body: api.body());
        return response;
    }
  }
}
