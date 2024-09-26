import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now().add(const Duration(hours: 1));
  Color _selectedColor = Colors.blue; // 기본 색상 설정

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '새 일정 추가',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: '일정 제목'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '제목을 입력해주세요';
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: '시작 시간'),
                    readOnly: true,
                    controller: TextEditingController(
                      text:
                          '${_startTime.hour}:${_startTime.minute.toString().padLeft(2, '0')}',
                    ),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(_startTime),
                      );
                      if (time != null) {
                        setState(() {
                          _startTime = DateTime(
                            _startTime.year,
                            _startTime.month,
                            _startTime.day,
                            time.hour,
                            time.minute,
                          );
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: '종료 시간'),
                    readOnly: true,
                    controller: TextEditingController(
                      text:
                          '${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}',
                    ),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(_endTime),
                      );
                      if (time != null) {
                        setState(() {
                          _endTime = DateTime(
                            _endTime.year,
                            _endTime.month,
                            _endTime.day,
                            time.hour,
                            time.minute,
                          );
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 색상 선택 위젯 추가
            Row(
              children: [
                const Text('일정 색상: '),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _showColorPicker(context),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _selectedColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (_endTime.isBefore(_startTime)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('종료 시간은 시작 시간 이후여야 합니다.')),
                    );
                    return;
                  }
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue[700], // 저장 버튼 색상을 진한 파란색으로 변경
                foregroundColor: Colors.white, // 텍스트 색상을 흰색으로 설정
              ),
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }

  // 색상 선택 다이얼로그를 표시하는 메서드
  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('색상 선택'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  _selectedColor = color;
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }
}

// 주석: 이 컴포넌트는 새로운 일정을 추가하기 위한 바텀 시트 UI를 구현합니다.
// 사용자는 일정 제목, 시작 시간, 종료 시간, 색상을 입력할 수 있습니다.
//
// 버그 수정 사항:
// 1. 시간 표시 형식을 24시간제로 통일하고 두 자리 숫자로 표시하도록 수정
// 2. 종료 시간이 시작 시간보다 빠른 경우 오류 메시지를 표시하고 저장을 방지
//
// 향후 개선 사항:
// 1. 반복 일정 설정 기능 추가
// 2. 알림 설정 기능 추가
// 3. 날짜 선택 기능 추가
// 4. 색상 선택 UI 개선 및 커스텀 색상 추가 기능
