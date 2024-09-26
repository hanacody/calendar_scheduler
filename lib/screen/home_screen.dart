import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  // 임시로 등록된 일정 개수를 저장하는 변수
  int scheduledCount = 0;

  // 임시 스케줄 데이터
  final List<Map<String, dynamic>> _schedules = [
    {
      'startTime': '09:00',
      'endTime': '10:00',
      'content': '아침 회의',
      'color': Colors.red,
    },
    {
      'startTime': '13:00',
      'endTime': '14:00',
      'content': '점심 식사',
      'color': Colors.blue,
    },
    {
      'startTime': '15:00',
      'endTime': '16:30',
      'content': '프로젝트 미팅',
      'color': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomTableCalendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  this.selectedDay = selectedDay;
                  this.focusedDay = focusedDay;
                  // 선택된 날짜에 따라 등록된 일정 개수를 업데이트하는 로직이 필요합니다.
                  // 예: scheduledCount = getScheduleCount(selectedDay);
                  scheduledCount = _schedules.length; // 임시로 고정된 값 사용
                });
              },
            ),
            TodayBanner(
              selectedDay: selectedDay,
              scheduledCount: scheduledCount,
            ),
            ScheduleList(schedules: _schedules),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return ScheduleBottomSheet();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
