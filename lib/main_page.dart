import 'package:dgsw_notification/data/Meal.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:toast/toast.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  static const mapString = 'DDISH_NM';

  // on back press to exit app 을 위한 카운트 변수
  DateTime backButtonPressedTime;

  // 현재 날짜를 가져오기 위한 변수
  DateTime now = DateTime.now();
  String todayDate;

  // api 에서 받아온 데이터 관련 변수
  Future<List<dynamic>> mealsList;
  int dataCount = 0;

  @override
  void initState() {
    todayDate = DateFormat('yyyyMMdd').format(now);
    mealsList = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backPress,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            child: Center(
              child: FutureBuilder(
                future: mealsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data[0][mapString],
                      style: TextStyle(
                        color: Colors.white
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    );
                  }

                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // open api 에서 데이터 받아오기
  Future<List<dynamic>> getData() async {
    print(todayDate);
    print('#######');
    const defaultUri = 'https://open.neis.go.kr/hub/mealServiceDietInfo?Key=11dfd3b3e3e248db9b75145834995a25&Type=json&pIndex=1&pSize=100&ATPT_OFCDC_SC_CODE=D10&SD_SCHUL_CODE=7240393&MLSV_YMD=';

    http.Response response = await http.get(
      Uri.encodeFull(defaultUri + todayDate),
    );

    Map<String, dynamic> map = jsonDecode(response.body);
    List<dynamic> data = map["mealServiceDietInfo"];
    List<dynamic> meals = data[1]['row'];

    print(response.statusCode.toString());
    print("###");

    return meals;
  }

  // 뒤로가기 구현
  Future<bool> _backPress() async {
    DateTime currentTime = DateTime.now();

    bool backButton = backButtonPressedTime == null ||
      currentTime.difference(backButtonPressedTime) > Duration(seconds: 3);

    if (backButton) {
      backButtonPressedTime = currentTime;
      Toast.show('뒤로가기 버튼을 한번 더 누르세요.', context);
      return false;
    }
    return true;
  }
}
