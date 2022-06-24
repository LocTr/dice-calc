enum DarkMode {
  light,
  dark,
  system,
}

enum WaitTime {
  opt_1(0.5),
  opt_2(1),
  opt_3(2);

  const WaitTime(this.value);
  final num value;
}
