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
}
