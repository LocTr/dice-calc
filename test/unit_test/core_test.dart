import 'package:dice_calc/logic/core/calc_logic.dart';
import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Single dice roll with multiplier',
    () {
      test('test dice roll result (1) | single empty d6', () {
        var result = <int>{};
        var expected = [1, 2, 3, 4, 5, 6];
        const List<Element> input = [DiceElement(content: '')];

        for (var i = 0; i < 1000; i++) {
          result.add(calculate(input));
        }
        expect(result, containsAll(expected));
      });
      test('test dice roll result (2)  | 3d7', () {
        var result = <int>{};
        var expected = List<int>.generate(18, (index) => index + 3);
        const List<Element> input = [
          NumberElement(content: '3'),
          DiceElement(content: '7'),
        ];

        for (var i = 0; i < 1000; i++) {
          result.add(calculate(input));
        }
        expect(result, containsAll(expected));
      });
    },
  );

  group('dice roll with single operator', () {
    test('plus op | 10 + 2d6', () {
      //this test case could fail at 1 in 7.06e-779 chances
      const List<Element> input = [
        NumberElement(content: '2'),
        OperatorElement(content: 'x', operator: Operator.multiply),
        DiceElement(content: ''),
      ];
      var result = <int>{};
      var expected = const [2, 4, 6, 8, 10, 12];
      for (var i = 0; i < 1000; i++) {
        result.add(calculate(input));
      }
      expect(result, containsAll(expected));
    });

    test('test dice roll with minus op', () {
      var result = <int>{};
      var expected = [-6, -5, -4, -3, -2, -1];
      const List<Element> input = [
        NumberElement(content: '0'),
        OperatorElement(content: '-', operator: Operator.minus),
        DiceElement(content: '6'),
      ];
      for (var i = 0; i < 1000; i++) {
        result.add(calculate(input));
      }
      expect(result, containsAll(expected));
    });

    test('multiply op | 2xd', () {
      //this test case could fail at 1 in 7.06e-779 chances
      const List<Element> input = [
        NumberElement(content: '2'),
        OperatorElement(content: 'x', operator: Operator.multiply),
        DiceElement(content: ''),
      ];
      var result = <int>{};
      var expected = const [2, 4, 6, 8, 10, 12];
      for (var i = 0; i < 1000; i++) {
        result.add(calculate(input));
      }
      expect(result, containsAll(expected));
    });
  });
}
