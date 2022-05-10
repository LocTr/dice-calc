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

    if (element[0] == '-') {
      isNegative = true;
      element = element.substring(1);
    }
    //is a dice
    if (element.contains('d')) {
      List<String> numbers = element.split('d');

      int diceType = int.parse(numbers.last);
      int numberOfDice = 1;
      if (numbers.length != 1) {
        numberOfDice == int.parse(numbers.first);
      }

      int point = diceRoll(diceType, numberOfDice);
    }
  }
  return result;
}

int diceRoll(int numberOfSide, int numberOfRoll) {
  var result = 0;
  for (var i = 0; i < numberOfRoll; i++) {
    result + (Random().nextInt(numberOfSide) + 1);
  }
  return result;
}
