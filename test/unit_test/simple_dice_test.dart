import 'package:dice_calc/logic/core/calc_logic.dart';
import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Single dice roll with multiplier',
    () {
      test('single empty d6', () {
        var result = <int>{};
        final expected = [1, 2, 3, 4, 5, 6];
        const List<Element> input = [DiceElement(content: 0)];

        for (var i = 0; i < 1000; i++) {
          result.add(calculate(input));
        }
        expect(result, hasLength(expected.length));
        expect(result, containsAll(expected));
      });
      test('3d7', () {
        var result = <int>{};
        final expected = List<int>.generate(19, (index) => index + 3);
        const List<Element> input = [
          NumberElement(content: 3),
          DiceElement(content: 7),
        ];

        for (var i = 0; i < 1000; i++) {
          result.add(calculate(input));
        }
        expect(result, hasLength(expected.length));
        expect(result, containsAll(expected));
      });
    },
  );

  group('dice roll with single operator', () {
    test('plus op | 10 + 2d6', () {
      //this test case could fail at 1 in 7.06e-779 chances
      const List<Element> input = [
        NumberElement(content: 2),
        OperatorElement(operator: Operator.multiply),
        DiceElement(content: 0),
      ];
      var result = <int>{};
      final expected = [2, 4, 6, 8, 10, 12];
      for (var i = 0; i < 1000; i++) {
        result.add(calculate(input));
      }
      expect(result, hasLength(expected.length));
      expect(result, containsAll(expected));
    });

    test('test dice roll with minus op', () {
      var result = <int>{};
      final expected = [-6, -5, -4, -3, -2, -1];
      const List<Element> input = [
        NumberElement(content: 0),
        OperatorElement(operator: Operator.minus),
        DiceElement(content: 6),
      ];
      for (var i = 0; i < 1000; i++) {
        result.add(calculate(input));
      }
      expect(result, hasLength(expected.length));
      expect(result, containsAll(expected));
    });

    test('multiply op | 3 multiply to empty d6', () {
      //this test case could fail at 1 in 7.06e-779 chances
      const List<Element> input = [
        NumberElement(content: 3),
        OperatorElement(operator: Operator.multiply),
        DiceElement(content: 0),
      ];
      var result = <int>{};
      final expected = [3, 6, 9, 12, 15, 18];
      for (var i = 0; i < 1000; i++) {
        result.add(calculate(input));
      }
      expect(result, hasLength(expected.length));
      expect(result, containsAll(expected));
    });

    test('divide op | 2 divided to empty d', () {
      //this test case could fail at 1 in 7.06e-779 chances
      const List<Element> input = [
        NumberElement(content: 2),
        OperatorElement(operator: Operator.divided),
        DiceElement(content: 0),
      ];
      var result = <int>{};
      final expected = [0, 1, 2];
      for (var i = 0; i < 1000; i++) {
        result.add(calculate(input));
      }
      expect(result, hasLength(expected.length));
      expect(result, containsAll(expected));
    });
  });

  group('dice roll with multiple operator', () {
    test('plus op | 10 + 10 + 10 + 10', () {
      //this test case could fail at 1 in 7.06e-779 chances
      const List<Element> input = [
        NumberElement(content: 10),
        OperatorElement(operator: Operator.plus),
        NumberElement(content: 10),
        OperatorElement(operator: Operator.plus),
        NumberElement(content: 10),
        OperatorElement(operator: Operator.plus),
        NumberElement(content: 10),
      ];
      var result = calculate(input);
      const expected = 40;
      expect(result, equals(expected));
    });
  });
}
