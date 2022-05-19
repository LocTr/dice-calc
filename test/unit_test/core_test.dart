import 'package:dice_calc/logic/core/calc_logic.dart';
import 'package:dice_calc/model/element.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Roll dice function', () {
    test('test dice roll result (1) | single empty d6', () {
      const List<Element> input = [DiceElement(content: '')];
      for (var i = 0; i < 1000; i++) {
        var result = rollDices(input);
        // minimum roll is 1, maximum roll is 11
        expect(result, inInclusiveRange(1, 6));
      }
    });

    test('test dice roll result (2)  | 3d7', () {
      const List<Element> input = [
        NumberElement(content: '3'),
        DiceElement(content: '7'),
      ];
      for (var i = 0; i < 1000; i++) {
        var result = rollDices(input);
        // minimum roll is -9, maximum roll is 3
        expect(result, inInclusiveRange(-9, 3));
      }
    });
  });
}
