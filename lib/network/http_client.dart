import 'package:http/http.dart';
import '/utils/result.dart';
import 'endpoint.dart';

// exception in network
class HttpExcep implements Exception {
  HttpExcep({required this.info});
  final String info;
  HttpExcep.networkError() : info = 'Network Error';
  HttpExcep.statusError() : info = 'Status Error';
  HttpExcep.decodeError() : info = 'Decode Error';
  HttpExcep.operationFailed() : info = 'Operation Failed';
  @override
  String toString() => info;
}

abstract class Networkable {
  Future<Result<Response>> req(Endpoint api);
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
  Future<Result<Response>> req(Endpoint api) async {
    try {
      final Response response;
      switch (api.method) {
        case ReqMethod.get:
          final uri = Uri(scheme: 'https', host: host, path: api.path, queryParameters: api.query());
          response = await get(uri, headers: api.heads(headers));
        case ReqMethod.post:
          final uri = Uri(scheme: 'https', host: host, path: api.path);
          response = await post(uri, headers: api.heads(headers), body: api.body());
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.ok(response);
      } else {
        return Result.error(HttpExcep.statusError());
      }
    } catch (e) {
      return Result.error(HttpExcep.networkError());
    }
  }
}
