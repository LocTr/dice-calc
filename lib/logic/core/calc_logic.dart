List<String> splitDice(String input) {
  List<String> result;
  final regex = RegExp(r'\+|\-');
  result = input.split(regex);
  return result;
}
