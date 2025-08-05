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
    final into = Map<String, String>.from(headers ?? {});
    if (method == ReqMethod.post && encoding == ReqEncoding.json) {
      into['Content-Type'] = 'application/json; charset=utf-8';
    }
    final map = Map<String, String>.from(base ?? {})..addAll(into);
    return map.isNotEmpty ? map : null;
  }

  Map<String, dynamic>? query() {
    final map = Map<String, dynamic>.from(parameters ?? {});
    map.updateAll((key, value) => Uri.encodeComponent(value.toString()));
    return map.isNotEmpty ? map : null;
  }

  // Map<String, dynamic>? / String
  Object? body() {
    final map = Map<String, dynamic>.from(parameters ?? {});
    if (method == ReqMethod.post && encoding == ReqEncoding.json) {
      return map.isNotEmpty ? jsonEncode(map) : null;
    } else {
      map.updateAll((key, value) => Uri.encodeComponent(value.toString()));
      return map.isNotEmpty ? map : null;
    }
  }
}
