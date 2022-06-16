// import 'package:dice_calc/logic/core/calc_logic.dart';
// import 'package:dice_calc/model/element.dart';
// import 'package:dice_calc/model/enums.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   group(
//     'explode range test',
//     () {
//       test('d2 explode on 2', () {
//         var result = <int>{};
//         final expected = [
//           1,
//           3,
//           5,
//           7,
//           9,
//           11,
//           13,
//         ];
//         const List<Element> input = [
//           NumberElement(content: '1'),
//           DiceElement(content: '2'),
//           RerollElement(
//               content: '2',
//               type: RerollType.explode,
//               condition: RerollCondition.only,
//               times: RerollTimes.always,
//               timesContent: '1'),
//         ];
//         for (var i = 0; i < 1000; i++) {
//           result.add(calculate(input));
//         }
//         expect(result, containsAll(expected));
//       });
//       test('d2 explode on 2 3 times', () {
//         var result = <int>{};
//         final expected = [1, 3, 5, 7, 8];
//         const List<Element> input = [
//           NumberElement(content: '1'),
//           DiceElement(content: '2'),
//           RerollElement(
//               content: '2',
//               type: RerollType.explode,
//               condition: RerollCondition.only,
//               times: RerollTimes.specific,
//               timesContent: '3'),
//         ];
//         for (var i = 0; i < 1000; i++) {
//           result.add(calculate(input));
//         }
//         expect(result.length, equals(expected.length));
//         expect(result, containsAll(expected));
//       });
//     },
//   );
// }
