import 'package:dgsw_notification/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'main_page.dart';

/// 2020-07-10 개발 시작
/// 대구소프트웨어고등학교의 급식 식단 및
/// 하루일과 시간을 그래프 및 % 로 보여주는
/// Flutter 기반 Android 및 IOS Application 입니다.
///
/// Start Developing 2020-07-10
/// This application is provide Daegu Software High School Stuends
/// with school meals menu and graph that time left to go home.
///
/// 2020-11-26 2차 수정
///
/// 2020-11-26 second fix
///
/// by Kevin Sangha Lee(DGSW 3기 이상하)
void main() {
  runApp(MyApp());
}

final materialThemeData = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  accentColor: Colors.blue,
  appBarTheme: AppBarTheme(color: Colors.blue),
  primaryColor: Colors.blue,
  secondaryHeaderColor: Colors.lightBlue,
  canvasColor: Colors.black,
  backgroundColor: Colors.white,
  textTheme: TextTheme().copyWith(body1: TextTheme().body1.apply(
    color: Colors.black,
  )),
);

final cupertinoTheme = CupertinoThemeData(
    primaryColor: Colors.blue,
    barBackgroundColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: CupertinoTextThemeData(
        primaryColor: Colors.blue,
        textStyle: TextStyle(
            color: Colors.black
        )
    )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'DGSW Notification :)',
      material: (context, platform) => MaterialAppData(
        theme: materialThemeData,
      ),
      cupertino: (context, platform) => CupertinoAppData(
        theme: cupertinoTheme,
      ),
      home: MainPage(),
    );
  }
}
