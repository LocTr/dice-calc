import 'package:dice_calc/logic/core/calc_logic.dart';
import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    //really there is no way to test these
    'dice roll with filter',
    () {
      test('5d keep highest 2', () {
        var result = <int>{};
        final expected = List.generate(11, (index) => index + 2);
        const List<Element> input = [
          NumberElement(content: '5'),
          DiceElement(content: ''),
          FilterElement(
            content: '2',
            type: FilterType.keep,
            filterCondition: FilterCondition.highest,
          )
        ];

        for (var i = 0; i < 10000; i++) {
          result.add(calculate(input));
        }
      });
      test('3d7', () {
        var result = <int>{};
        final expected = List<int>.generate(19, (index) => index + 3);
        const List<Element> input = [
          NumberElement(content: '3'),
          DiceElement(content: '7'),
        ];

        for (var i = 0; i < 10000; i++) {
          result.add(calculate(input));
        }
        expect(result, hasLength(expected.length));
        expect(result, containsAll(expected));
      });
    },
  );
}
