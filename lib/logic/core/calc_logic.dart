import 'dart:math';

List<String> splitDice(String input) {
  List<String> result;
  // ?= is lookahead regex
  // this regex mean split by '+' or by the space before '-'
  // hence it keep the minus sign if present.
  final regex = RegExp(r'(\+)|(?=\-)');
  result = input.split(regex);
  return result;
}

List<String> addChar(String input) {
  List<String> result = [];
  return result;
}

int rollDices(List<String> input) {
  int result = 0;
  //element is dices or bonuses
  for (var element in input) {
    bool isNegative = false;
    int point;

    //check plus or minus
    if (element[0] == '-') {
      isNegative = true;
      element = element.substring(1);
    }
    // is a dice
    if (element.contains('d')) {
      List<String> numbers = element.split('d');

      int diceType = int.parse(numbers.last);
      // split return empty substring if match at the start or end of the string
      int numberOfDice = int.tryParse(numbers.first) ?? 1;
      point = diceRoll(diceType, numberOfDice);
    }
    // is a bonus
    else {
      point = int.parse(element);
    }

    isNegative ? result -= point : result += point;
  }

  return result;
}

int diceRoll(int numberOfSide, int numberOfRoll) {
  var result = 0;
  for (var i = 0; i < numberOfRoll; i++) {
    result += (Random().nextInt(numberOfSide) + 1);
  }
  return result;
}
