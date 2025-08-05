extension MapExt<K, V> on Map<K, V> {
  void put(K k, V? v) {
    if (v is V) {
      this[k] = v;
    } else {
      remove(k);
    }
  }
}
