import 'package:dgsw_notification/main_page.dart';
import 'package:flutter/material.dart';

/// 2020-07-10 개발 시작
/// 대구소프트웨어고등학교의 급식 식단 및
/// 정기 퇴사 까지 남은 시간을 그래프 및 % 로 보여주는
/// Flutter 기반 Android 및 IOS Application 입니다.
///
/// Start Developing 2020-07-10
/// This application is provide Daegu Software High School Stuends
/// with school meals menu and graph that time left to go home.
///
/// by Kevin Sangha Lee(DGSW 3기 이상하)
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainPage(),
    title: 'DGSW Notification :)',
  ));
}

