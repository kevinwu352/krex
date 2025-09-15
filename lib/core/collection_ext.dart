part of 'core.dart';

extension MapExt<K, V> on Map<K, V> {
  void setValue(K k, V? v) {
    if (v is V) {
      this[k] = v;
    } else {
      remove(k);
    }
  }

  Map<String, V> keyed([bool convert = false]) {
    if (this is Map<String, V>) {
      return cast<String, V>();
    } else {
      if (convert) {
        return map((k, v) => MapEntry(k is String ? k : k.toString(), v));
      } else {
        return Map.fromEntries(
          entries.map((e) => MapEntry(e.key is String ? e.key : null, e.value)).where((e) => e.key != null),
        ).cast<String, V>();
      }
    }
  }

  Map<K, V> where(bool Function(K k, V v) test) => Map.fromEntries(entries.where((e) => test(e.key, e.value)));

  Map<K, T> whereType<T>() => Map.fromEntries(entries.where((e) => e.value is T)).cast<K, T>();

  Map<K, R> compactMap<R>(R? Function(K k, V v) transform) => Map.fromEntries(
    entries.map((e) => MapEntry(e.key, transform(e.key, e.value))).where((e) => e.value != null),
  ).cast<K, R>();
}

extension IterableExt<T> on Iterable<T> {
  Iterable<R> compactMap<R>(R? Function(T e) transform) => map((e) => transform(e)).whereType<R>();
}
