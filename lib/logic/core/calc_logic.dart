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
    //is a dice
    if (element.contains('d')) {}
  }
  return result;
}
