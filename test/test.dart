import 'package:flutter_test/flutter_test.dart';

void main() {
  test(' split string into dices and bonuses (1)', () {
    var str = '-';
    int result = int.tryParse(str) ?? 0;
    print(result);
    expect(result, -5);
  });
}
