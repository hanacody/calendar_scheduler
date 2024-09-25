import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 한국어 로케일로 초기화. 다른 언어를 사용하려면 해당 로케일 코드로 변경하세요.
  await initializeDateFormatting('ko_KR', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '캘린더 스케줄러',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
