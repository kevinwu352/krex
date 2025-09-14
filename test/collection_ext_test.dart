import 'package:flutter_test/flutter_test.dart';

import 'package:krex/core/collection_ext.dart';

void main() {
  group('Map Ext Tests', () {
    test('map where', () {
      Map<String, int?> map = {'a': 1, 'b': null, 'c': 3, 'd': null};
      final map1 = map.where((k, v) => v is int);
      expect(map1, {'a': 1, 'c': 3});
      expect(map1, isA<Map<String, int?>>());
      // expect(map1, isA<Map<String, int>>());
    });

    test('map whereType', () {
      Map<String, dynamic> map = {'a': 1, 'b': 'xxx', 'c': 3, 'd': 'yyy'};
      final map1 = map.whereType<int>();
      expect(map1, {'a': 1, 'c': 3});
      expect(map1, isA<Map<String, int>>());
    });
  });

  group('Iterable Ext Tests', () {
    test('iterable compactMap', () {
      final list1 = [1, 2, 3, 4];
      final list11 = list1.compactMap((e) => e % 2 == 0 ? '$e$e' : null).toList();
      expect(list11, ['22', '44']);
      expect(list11, isA<List<String>>());

      final list2 = [1, 2, 3, null, 4];
      final list21 = list2.compactMap((e) => e != null && e % 2 == 0 ? '$e$e' : null).toList();
      expect(list21, ['22', '44']);
      expect(list21, isA<List<String>>());

      final list22 = list2.compactMap((e) => e).toList();
      expect(list22, [1, 2, 3, 4]);
      expect(list22, isA<List<int>>());
    });
  });
}
