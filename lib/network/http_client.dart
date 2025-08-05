import 'package:http/http.dart' as http;
import 'endpoint.dart';

abstract class Networkable {
  Future<void> req();
}

final class HttpClient implements Networkable {
  HttpClient({required this.host, required this.headers});

  final String host;
  final Map<String, String> headers;

  // HttpClient.token(String? token) : host = 'dummyjson.com', headers = {'token': ?token};
  HttpClient.token(String? token) : host = 'www.testingmcafeesites.com', headers = {'token': ?token};

  void setToken(String? token) {
    if (token is String) {
      headers['token'] = token;
    } else {
      headers.remove('token');
    }
  }

  @override
  Future<void> req() async {
    // https://dummyjson.com/c/08c8-ac33-4baa-b6ef
    // http://www.testingmcafeesites.com/testcat_al.html

    // final api = Endpoint(
    //   path: '/c/08c8-ac33-4baa-b6ef',
    //   method: ReqMethod.get,
    //   // parameters: {'k': '123'},
    //   // headers: {'tk': 'asdf'},
    //   parameters: {},
    //   headers: {},
    // );

    // final api = Endpoint('/c/08c8-ac33-4baa-b6ef', ReqMethod.get, parameters: null, headers: null);
    // final api = Endpoint('/c/08c8-ac33-4baa-b6ef', ReqMethod.post, parameters: {'kk': 'vv'}, headers: null);
    final api = Endpoint('/testcat_al.html', ReqMethod.post, parameters: {'kk': 123}, headers: {'tk': 'asdf'});

    if (api.method == ReqMethod.get) {
      final uri = Uri(scheme: 'https', host: host, path: api.path, queryParameters: api.paras());
      final response = await http.get(uri, headers: api.heads(headers));
      print(response.body);
    } else if (api.method == ReqMethod.post) {
      final uri = Uri(scheme: 'http', host: host, path: api.path);
      final response = await http.post(uri, headers: api.heads(headers), body: api.paras());
      print(response.body);
    }

    // POST 时
    // 参数传 String，头里面是 text/plain
    // 参数传 [97, 98, 99]，内容是 abc
    // 参数传 {'kk':'vv'}，头里面是 application/x-www-form-urlencoded
    // 参数传 {'kk':123}，会崩

    // query 的 value 不能是数字，所以，最好全给字符串
    // path 前加不加 / 都行
    // final uri = Uri(scheme: 'https', host: 'www.foo.com', path: '', queryParameters: {'k': '123'});
    // print(uri);
  }
}
