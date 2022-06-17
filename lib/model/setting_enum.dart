enum darkMode {
  light,
  dark,
  system,
}

enum waitTime {
  opt_1(0.5),
  opt_2(1),
  opt_3(2);

  const waitTime(this.value);
  final num value;
}
