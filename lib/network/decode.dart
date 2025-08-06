import 'dart:convert';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

T str2obj<T>(String str, FromJson<T> fromJson) {
  final Map<String, dynamic> json = jsonDecode(str);
  return fromJson(json);
}

List<T> str2list<T>(String str, FromJson<T> fromJson) {
  final List<dynamic> json = jsonDecode(str);
  return json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
}

T key2obj<T>(String str, String key, FromJson<T> fromJson) {
  final Map<String, dynamic> json = jsonDecode(str);
  final Map<String, dynamic> data = json[key];
  return fromJson(data);
}

List<T> key2list<T>(String str, String key, FromJson<T> fromJson) {
  final Map<String, dynamic> json = jsonDecode(str);
  final List<dynamic> data = json[key];
  return data.map((e) => fromJson(e as Map<String, dynamic>)).toList();
}

T json2obj<T>(Map<String, dynamic> json, FromJson<T> fromJson) {
  return fromJson(json);
}

List<T> json2list<T>(List<dynamic> json, FromJson<T> fromJson) {
  return json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
}
