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

  Map<K, V> nonNulls() {
    return Map<K, V>();
  }

  // Iterable<T> get nonNulls => NonNullsIterable<T>(this);

  // Iterable<T> whereType<T>() => WhereTypeIterable<T>(this);
  // Map<K, T> whereTypex<T>() {
  //   // final list = entries.whereType<MapEntry<K, T>>();
  //   // final list = entries.where((e) => e.value is T).cast<MapEntry<K, T>>();
  //   final list = entries.where((e) => e.value is T);
  //   print(list);
  //   print(list.runtimeType);
  //   print('111');
  //   final mmm = Map.fromEntries(list).cast<K, T>();
  //   print('222');
  //   print(mmm);
  //   print(mmm.runtimeType);
  //   print('333');
  //   return mmm;

  //   // return Map<K, T>();
  // }

  // Map<K, V> where(bool Function(K k, V v) test) {
  //   return Map.fromEntries(entries.where((e) => test(e.key, e.value)));
  //   // final list = entries.where((e) => test(e.key, e.value));
  //   // final mmm = Map.fromEntries(list);
  //   // return mmm;

  //   //   entries.where((entry) => entry.value != null)
  //   // .map((entry) => MapEntry(entry.key, entry.value as int)), // Cast to non-nullable int

  //   // return this;
  //   //     return Map.fromEntries(
  //   //   entries.where((entry) => entry.value != null)
  //   //     .map((entry) => MapEntry(entry.key, entry.value as int)), // Cast to non-nullable int
  //   // );
  // }
}

void foo() {
  Map<String, int?> amap = {'a': 1, 'b': null, 'c': 3, 'd': null};
  // amap.whe
  // amap.forEach((key, value) => ,)
  // amap.whe
  // final a = amap.nonNulls;
}
