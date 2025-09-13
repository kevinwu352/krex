// num? n = 12 as dynamic;
// n = null;
//
// final aa = n.as<int>();
// print(aa);
//
// final bb = n.asOr<int>() ?? 102;
// print(bb);

extension AsExt on Object? {
  X as<X>() => this as X;

  X? asOr<X>() {
    var self = this;
    return self is X ? self : null;
  }
}
