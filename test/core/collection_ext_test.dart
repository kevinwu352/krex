import 'package:flutter_test/flutter_test.dart';

import 'package:krex/core/core.dart';

void main() {
  group('MapExtTests', () {
    test('map.setValue', () {
      final map = {'a': 1, 'b': 2};

      map.setValue('c', 3);
      expect(map, {'a': 1, 'b': 2, 'c': 3});

      map.setValue('c', null);
      expect(map, {'a': 1, 'b': 2});
    });

    test('map.keyed', () {
      final map1 = {'a': 1};
      final map11 = map1.keyed();
      expect(map11, {'a': 1});
      expect(map11, isA<Map<String, int>>());

      final map2 = {'a': 1, 'b': 'x'};
      final map21 = map2.keyed();
      expect(map21, {'a': 1, 'b': 'x'});
      expect(map21, isA<Map<String, Object>>());

      final map3 = {'a': 1, 'b': 'x', 1: 11};
      final map31 = map3.keyed();
      expect(map31, {'a': 1, 'b': 'x'});
      expect(map31, isA<Map<String, Object>>());

      final map4 = {'a': 1, 'b': 'x', 1: 11, null: null};
      final map41 = map4.keyed();
      expect(map41, {'a': 1, 'b': 'x'});
      expect(map41, isA<Map<String, Object?>>());
    });

    test('map.toKeyed', () {
      final map1 = {'a': 1};
      final map11 = map1.toKeyed();
      expect(map11, {'a': 1});
      expect(map11, isA<Map<String, int>>());

      final map2 = {'a': 1, 'b': 'x'};
      final map21 = map2.toKeyed();
      expect(map21, {'a': 1, 'b': 'x'});
      expect(map21, isA<Map<String, Object>>());

      final map3 = {'a': 1, 'b': 'x', 1: 11};
      final map31 = map3.toKeyed();
      expect(map31, {'a': 1, 'b': 'x', '1': 11});
      expect(map31, isA<Map<String, Object>>());

      final map4 = {'a': 1, 'b': 'x', 1: 11, null: null, '1': 'xx'};
      final map41 = map4.toKeyed();
      expect(map41, {'a': 1, 'b': 'x', '1': 'xx', 'null': null});
      expect(map41, isA<Map<String, Object?>>());
    });

    test('map.where', () {
      final map = {'a': 1, 'b': null, 'c': 3, 'd': null};
      final map1 = map.where((k, v) => v is int);
      expect(map1, {'a': 1, 'c': 3});
      expect(map1, isA<Map<String, int?>>());
      // expect(map1, isA<Map<String, int>>());
    });

    test('map.whereType', () {
      final map = {'a': 1, 'b': 'xxx', 'c': 3, 'd': 'yyy'};
      final map1 = map.whereType<int>();
      expect(map1, {'a': 1, 'c': 3});
      expect(map1, isA<Map<String, int>>());
    });

    test('map.compactMap', () {
      final map = {'a': 1, 'b': 2, 'c': 3, 'd': 4};
      final map1 = map.compactMap((k, v) => v.isOdd ? v * v : null);
      expect(map1, {'a': 1, 'c': 9});
      expect(map1, isA<Map<String, int>>());
    });
  });

  group('IterableExtTests', () {
    test('iterable.compactMap', () {
      final list1 = [1, 2, 3, 4];
      final list11 = list1.compactMap((e) => e.isEven ? '$e$e' : null).toList();
      expect(list11, ['22', '44']);
      expect(list11, isA<List<String>>());

      final list2 = [1, 2, 3, null, 4];
      final list21 = list2.compactMap((e) => e != null && e.isEven ? '$e$e' : null).toList();
      expect(list21, ['22', '44']);
      expect(list21, isA<List<String>>());

      final list22 = list2.compactMap((e) => e).toList();
      expect(list22, [1, 2, 3, 4]);
      expect(list22, isA<List<int>>());
    });
  });
}
