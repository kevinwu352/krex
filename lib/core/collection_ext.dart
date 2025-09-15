part of 'core.dart';

extension MapExt<K, V> on Map<K, V> {
  // void put(K k, V? v) {
  //   if (v is V) {
  //     this[k] = v;
  //   } else {
  //     remove(k);
  //   }
  // }

  Map<K, V> where(bool Function(K k, V v) test) => Map.fromEntries(entries.where((e) => test(e.key, e.value)));

  Map<K, T> whereType<T>() => Map.fromEntries(entries.where((e) => e.value is T)).cast<K, T>();
}

extension IterableExt<T> on Iterable<T> {
  Iterable<R> compactMap<R>(R? Function(T e) transform) => map((e) => transform(e)).whereType<R>();
}
