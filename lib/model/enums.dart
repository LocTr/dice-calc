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

enum RerollTimes {
  once,
  twice,
  thrice,
  specific,
  always,
}

enum RerollType {
  reroll,
  explode,
}

enum RerollCondition {
  none,
  only,
  more,
  less,
}
