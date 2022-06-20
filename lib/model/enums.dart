enum Operator {
  plus,
  minus,
  multiply,
  divided,
}

enum FilterType {
  drop,
  keep,
}

enum FilterCondition {
  none,
  lowest,
  highest,
}

enum RerollType {
  reroll('r'),
  explode('e');

  const RerollType(this.content);
  final String content;
}

enum RerollTimes {
  none,
  specific,
  always,
}

enum RerollCondition {
  only(''),
  more('\u2265'),
  less('\u2264');

  const RerollCondition(this.content);
  final String content;
}
