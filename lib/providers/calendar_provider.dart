import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarProvider extends StateNotifier<CalendarState> {
  CalendarProvider() : super(CalendarState(focusedDay: DateTime.now()));

  void setFocusedDay(DateTime newFocusedDay) {
    state = state.copyWith(focusedDay: newFocusedDay);
  }

  void setSelectedDay(DateTime newSelectedDay) {
    state = state.copyWith(focusedDay: newSelectedDay, selectedDay: newSelectedDay);
  }

  void goToPreviousMonth() {
    DateTime newFocusedDay = state.focusedDay.month == 1
        ? DateTime(state.focusedDay.year - 1, 12, 1)
        : DateTime(state.focusedDay.year, state.focusedDay.month - 1, 1);

    state = state.copyWith(focusedDay: newFocusedDay);
  }

  void goToNextMonth() {
    DateTime newFocusedDay = state.focusedDay.month == 12
        ? DateTime(state.focusedDay.year + 1, 1, 1)
        : DateTime(state.focusedDay.year, state.focusedDay.month + 1, 1);

    state = state.copyWith(focusedDay: newFocusedDay);
  }
}

final calendarProvider =
    StateNotifierProvider<CalendarProvider, CalendarState>((ref) {
  return CalendarProvider();
});

class CalendarState {
  final DateTime focusedDay;
  final DateTime? selectedDay;

  CalendarState({required this.focusedDay, this.selectedDay});

  CalendarState copyWith({DateTime? focusedDay, DateTime? selectedDay}) {
    return CalendarState(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}
