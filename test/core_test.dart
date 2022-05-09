import 'package:dice_calc/logic/core/calc_logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Screen string should split into dices and bonuses', () {
    const String input = '2d2+4d6-7';
    final result = splitDice(input);
    expect(result[0], '2d2');
    expect(result[1], '4d6');
    expect(result[2], '-7');
  });

  test('test dice roll result', () {
    var input = List<String>.empty();
    input = ['d2', '2d3', 'd6', '-3'];
    for (var i = 0; i < 1000; i++) {
      var result = rollDices(input);
      // minimum roll is 1, maximum roll is 11
      expect(result, inInclusiveRange(1, 11));
    }
  });
}
