import 'package:flutter/material.dart';

// ScheduleCard 위젯: 개별 일정 항목을 표시하는 카드
class ScheduleCard extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String content;
  final Color color;

  const ScheduleCard({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildColorBar(),
              const SizedBox(width: 16.0),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorBar() {
    return Container(
      width: 4.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.0),
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$startTime - $endTime',
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            content,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

// 주석: ScheduleCard 위젯은 개별 일정 항목을 표시하는 카드입니다.
// 시작 시간, 종료 시간, 내용, 색상을 입력받아 일관된 디자인으로 표시합니다.
//
// 향후 개선 사항:
// 1. 긴 내용을 위한 텍스트 오버플로우 처리
// 2. 터치 이벤트 처리를 위한 콜백 함수 추가
// 3. 다양한 스타일 옵션을 위한 추가 매개변수 도입

// ScheduleList 위젯: 여러 개의 ScheduleCard를 리스트로 표시
class ScheduleList extends StatelessWidget {
  final List<Map<String, dynamic>> schedules;

  const ScheduleList({Key? key, required this.schedules}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ScheduleCard(
              startTime: schedule['startTime'] as String,
              endTime: schedule['endTime'] as String,
              content: schedule['content'] as String,
              color: schedule['color'] as Color,
            ),
          );
        },
      ),
    );
  }
}

// 주석: ScheduleList 위젯은 여러 개의 ScheduleCard를 리스트 형태로 표시합니다.
// schedules 리스트를 입력받아 각 항목을 ScheduleCard로 변환하여 출력합니다.
//
// 향후 개선 사항:
// 1. 빈 리스트 처리를 위한 EmptyState 위젯 추가
// 2. 무한 스크롤 또는 페이지네이션 구현
// 3. 스케줄 항목 간 구분선 추가 옵션
