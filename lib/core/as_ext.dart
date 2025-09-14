part of 'core.dart';

// num? n = 12 as dynamic;
// n = null;
//
// final aa = n.as<int>();
// print(aa);
//
// final bb = n.asOr<int>() ?? 102;
// print(bb);

extension AsExt on Object? {
  T as<T>() => this as T;

  T? asOr<T>() {
    var self = this;
    return self is T ? self : null;
  }
}

void asTests() {
  // final aa = _getInt().as<int>();
  // print(aa);
  // final bb = _getInt().asOr();
  // print(bb);

  // Object mp = {'int': 12, 'double': 1.3, 'xx': 'asdf'};
  // print(mp.runtimeType);
  // final xx = mp.asOr<Map<dynamic, dynamic>>();
  // print(xx);

  final map = _getMap();
  print(map.runtimeType);
  // final aa = map.asOr<Map<Object, Object>>();
  // print(aa);

  // final bb = map as Map<String, dynamic>;
  // print(bb);

  map?.forEach((key, value) => print(key.runtimeType));

  final map2 = _getMap2();
  print(map2.runtimeType);
  final cc = map2 as Map<String, dynamic>;
  print(cc);
}

int? _getInt() {
  return null;
}

Map? _getMap() {
  return {'int': 12, 'double': 1.3};
}

Map<String, dynamic>? _getMap2() {
  return {'int': 12, 'double': 1.3};
}
