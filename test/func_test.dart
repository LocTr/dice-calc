import 'package:flutter_test/flutter_test.dart';

void main() {
  test('playground', () {
    var str = 'd7';
    List<String> numbers = str.split('d');
    for (var item in numbers) {
      print('here:' + item);
    }
    expect(numbers[1], '7');
  });
}
