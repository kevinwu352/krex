import 'dart:convert';

enum ReqMethod { get, post }

enum ReqEncoding { url, json }

class Endpoint {
  Endpoint(this.path, this.method, {this.parameters, this.encoding = ReqEncoding.url, this.headers});

  final String path;
  final ReqMethod method;
  final Map<String, dynamic>? parameters;
  final ReqEncoding encoding;
  final Map<String, String>? headers;

  Map<String, String>? heads(Map<String, String>? base) {
    final into = Map.of(headers ?? <String, String>{});
    if (method == ReqMethod.post && encoding == ReqEncoding.json) {
      into['Content-Type'] = 'application/json; charset=utf-8';
    }
    final map = Map.of(base ?? <String, String>{})..addAll(into);
    return map.isNotEmpty ? map : null;
  }

  Map<String, dynamic>? query() {
    final map = Map.of(parameters ?? <String, dynamic>{});
    map.updateAll((key, value) => Uri.encodeComponent(value.toString()));
    return map.isNotEmpty ? map : null;
  }

  // Map<String, dynamic>? / String
  Object? body() {
    final map = Map.of(parameters ?? <String, dynamic>{});
    if (method == ReqMethod.post && encoding == ReqEncoding.json) {
      return map.isNotEmpty ? jsonEncode(map) : null;
    } else {
      map.updateAll((key, value) => Uri.encodeComponent(value.toString()));
      return map.isNotEmpty ? map : null;
    }
  }
}
