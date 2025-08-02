extension Ext on String {
  // '1.2.3' => 1002003
  int get extendedVersionNumber =>
      split('.').map((e) => int.parse(e)).fold(0, (p, e) => p * 1000 + e);
}
