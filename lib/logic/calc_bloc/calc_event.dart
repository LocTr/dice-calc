import 'package:dice_calc/model/calc_button_enum.dart';
import 'package:dice_calc/widget/calc_button.dart';
import 'package:flutter/cupertino.dart';

abstract class CalcEvent {}

class AddCharEvent extends CalcEvent {
  AddCharEvent(this.char);
  final String char;
}

class ClearScreenEvent extends CalcEvent {}
