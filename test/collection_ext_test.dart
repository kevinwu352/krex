import 'package:flutter_test/flutter_test.dart';

import 'package:krex/core/collection_ext.dart';

void main() {
  group('Collection Ext Tests', () {
    test('map where', () {
      Map<String, int?> map = {'a': 1, 'b': null, 'c': 3, 'd': null};
      final map1 = map.where((k, v) => v is int);
      expect(map1, {'a': 1, 'c': 3});
      expect(map1, isA<Map<String, int?>>());
    });

    test('map whereType', () {
      Map<String, dynamic> map = {'a': 1, 'b': 'xxx', 'c': 3, 'd': 'yyy'};
      final map1 = map.whereType<int>();
      expect(map1, {'a': 1, 'c': 3});
      expect(map1, isA<Map<String, int>>());
    });
  });
}
