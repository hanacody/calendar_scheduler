import 'package:flutter/material.dart';

class Schedule {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final Color color;
  final DateTime createdAt; // 일정 생성 시간 추가

  Schedule({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.createdAt, // 생성자에 createdAt 추가
  });

  // JSON 데이터로부터 Schedule 객체를 생성하는 팩토리 생성자
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] as String,
      title: json['title'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      color: Color(json['color'] as int),
      createdAt:
          DateTime.parse(json['createdAt'] as String), // JSON에서 createdAt 파싱
    );
  }

  // Schedule 객체를 JSON 형태로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'color': color.value,
      'createdAt': createdAt.toIso8601String(), // JSON에 createdAt 추가
    };
  }
}

// 주석: Schedule 클래스는 일정 정보를 관리하는 모델입니다.
// 각 일정은 고유 ID, 제목, 시작 시간, 종료 시간, 색상 정보, 생성 시간을 가집니다.
// JSON 변환 메서드를 통해 데이터 저장 및 불러오기를 용이하게 합니다.

// 향후 개선 사항:
// 1. 반복 일정을 위한 속성 추가 (예: 반복 주기, 종료일)
// 2. 알림 설정을 위한 속성 추가
// 3. 일정 설명(description) 필드 추가
// 4. 일정 수정 시간(updatedAt) 필드 추가
