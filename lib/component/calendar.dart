import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final Function(DateTime, DateTime) onDaySelected;

  const CustomTableCalendar({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
          color: Colors.indigo,
        ),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.indigo.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: Colors.indigo,
          shape: BoxShape.circle,
        ),
        weekendTextStyle: const TextStyle(color: Colors.red),
        outsideDaysVisible: false,
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.black87),
        weekendStyle: TextStyle(color: Colors.red),
      ),
      onDaySelected: onDaySelected,
      selectedDayPredicate: (date) {
        return isSameDay(selectedDay, date);
      },
    );
  }
}

// 주석: 이 컴포넌트는 HomeScreen에서 캘린더 부분만을 분리하여 재사용 가능한 위젯으로 만들었습니다.
// 향후 개선 사항: 캘린더의 스타일을 더 쉽게 커스터마이징할 수 있도록 추가 매개변수를 도입할 수 있습니다.
