import 'package:dice_calc/logic/core/calc_logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Split function', () {
    test(' split string into dices and bonuses (1)', () {
      const String input = '2d2+4d6-7';
      final result = splitDice(input);
      expect(result[0], '2d2');
      expect(result[1], '4d6');
      expect(result[2], '-7');
    });

    test(' split string into dices and bonuses (2)', () {
      const String input = '-5+d4-2d6';
      final result = splitDice(input);
      expect(result[0], '-5');
      expect(result[1], 'd4');
      expect(result[2], '-2d6');
    });
  });

  group('Roll dice function', () {
    test('test dice roll result (1)', () {
      var input = List<String>.empty();
      input = ['d2', '2d3', 'd6', '-3'];
      for (var i = 0; i < 1000; i++) {
        var result = rollDices(input);
        // minimum roll is 1, maximum roll is 11
        expect(result, inInclusiveRange(1, 11));
      }
    });

    test('test dice roll result (2)', () {
      var input = List<String>.empty();
      input = ['-4d2', '3d2', '-5', 'd6'];
      for (var i = 0; i < 1000; i++) {
        var result = rollDices(input);
        // minimum roll is -9, maximum roll is 3
        expect(result, inInclusiveRange(-9, 3));
      }
    });
  });
}
