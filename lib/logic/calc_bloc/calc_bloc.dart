import 'dart:async';

import 'calc_event.dart';
import 'calc_state.dart';

class CalcBloc {
  var state = CalcState('');

  // event controller is for handling event from UI component
  final eventController = StreamController<CalcEvent>();

  // stateController is for updating new state to UI component
  final stateController = StreamController<CalcState>();

  CalcBloc() {
    // subcribe to the eventController to perform action (update the state) when event is created
    eventController.stream.listen((event) {
      if (event is AddCharEvent) {
        state = CalcState(state.screenString + event.char);
      } else if (event is ClearScreenEvent) {
        state = CalcState('');
      }
      //then add this state to the stateController sink for updating UI
      stateController.sink.add(state);
    });
  }

  // dispose function for closing the streams when not needed
  void dispose() {
    stateController.close();
    eventController.close();
  }
}
