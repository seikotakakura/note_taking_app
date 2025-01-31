import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:note_taking_app/providers/calendar_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarProvider);

    return Scaffold(
      backgroundColor: Color(0xFFf2f3f7),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            //** Header */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black.withAlpha(60),
                          size: 14.0,
                        ),
                        onPressed: () {
                          ref
                              .read(calendarProvider.notifier)
                              .goToPreviousMonth();
                        },
                      ),
                      Text(
                        DateFormat('MMMM yyyy')
                            .format(calendarState.focusedDay),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black.withAlpha(60),
                          size: 14.0,
                        ),
                        onPressed: () {
                          ref.read(calendarProvider.notifier).goToNextMonth();
                        },
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      // Aksi simpan catatan
                    }, // Warna ikon agak gelap
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Colors.black.withAlpha(9), // Transparan hitam
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Biar rounded
                      ),
                    ),
                    child: Text(
                      "Event +",
                      style: TextStyle(
                        fontFamily: 'Merriweather',
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.0),

            /** Kalender */
            TableCalendar(
              focusedDay: calendarState.focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              headerVisible: false,
              selectedDayPredicate: (day) {
                return isSameDay(calendarState.selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(calendarState.selectedDay, selectedDay)) {
                  ref
                      .read(calendarProvider.notifier)
                      .setSelectedDay(selectedDay);
                }
              },
              onPageChanged: (newFocusedDay) {
                ref
                    .read(calendarProvider.notifier)
                    .setFocusedDay(newFocusedDay);
              },
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.black.withAlpha(100)),
                weekendStyle: TextStyle(color: Colors.red),
              ),
              calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(color: Colors.black),
                weekendTextStyle: TextStyle(color: Colors.black),
                outsideTextStyle: TextStyle(color: Colors.black),
                todayDecoration: BoxDecoration(
                  color: Colors.orange.withAlpha(190),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                selectedTextStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Task Schedule',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /**Task Schedule */
          ],
        ),
      ),
    );
  }
}
