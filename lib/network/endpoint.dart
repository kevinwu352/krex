// public protocol Endpoint {
//     var path: String { get }
//     var method: ReqMethod { get }
//     var parameters: [String: Encodable]? { get }
//     var encoding: ReqEncoding { get }
//     var headers: [String: String]? { get }
// }

enum ReqMethod { get, post }

class Endpoint {
  Endpoint(this.path, this.method, {this.parameters, this.headers});

  final String path;
  final ReqMethod method;
  final Map<String, dynamic>? parameters;
  final Map<String, String>? headers;

  Map<String, String>? heads(Map<String, String>? base) {
    final map = Map<String, String>.from(base ?? {})..addAll(headers ?? {});
    return map.isNotEmpty ? map : null;
  }

  Map<String, dynamic>? paras() {
    final map = parameters ?? {};
    map.updateAll((key, value) => value.toString());
    return map.isNotEmpty ? map : null;
  }
}
