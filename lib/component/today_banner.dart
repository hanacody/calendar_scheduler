import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  final int scheduledCount;

  const TodayBanner({
    Key? key,
    required this.selectedDay,
    required this.scheduledCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('yyyy년 MM월 dd일').format(selectedDay),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '등록된 일정: $scheduledCount개',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// 주석: 이 컴포넌트는 HomeScreen에서 하단 배너 부분을 분리하여 재사용 가능한 위젯으로 만들었습니다.
// 향후 개선 사항: 
// 1. 텍스트 스타일을 더 쉽게 커스터마이징할 수 있도록 추가 매개변수를 도입할 수 있습니다.
// 2. 다국어 지원을 위해 날짜 형식을 외부에서 주입받을 수 있도록 수정할 수 있습니다.
