enum Operator {
  plus,
  minus,
  multiply,
  divided,
}

enum FilterType {
  drop('d'),
  keep('k');

  const FilterType(this.content);
  final String content;
}

enum FilterCondition {
  none(''),
  lowest('l'),
  highest('h');

  const FilterCondition(this.content);
  final String content;
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
