import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
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
          child: Center(
            child: FutureBuilder(
              future: mealsList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  print(data.length);
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var subData = data[index][mapString].toString().split('<br/>');
                        return menuListView(subData, index);
                      }
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  );
                }
                return CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: new AlwaysStoppedAnimation(Colors.lightBlue),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // open api 에서 데이터 받아오기
  Future<List<dynamic>> getData() async {
    const defaultUri = 'https://open.neis.go.kr/hub/mealServiceDietInfo?Key=11dfd3b3e3e248db9b75145834995a25&Type=json&pIndex=1&pSize=100&ATPT_OFCDC_SC_CODE=D10&SD_SCHUL_CODE=7240393&MLSV_YMD=';

    http.Response response = await http.get(
      Uri.encodeFull(defaultUri + '20200713'),
    );

    Map<String, dynamic> map = jsonDecode(response.body);
    List<dynamic> data = map["mealServiceDietInfo"];
    List<dynamic> meals = data[1]['row'];

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

  // data를 받아와서 시간대 별로 뛰우는 작업 진행
  Widget menuListView(List<String> menuList, int timeIndex) {
    var mealtime = '식사시간';
    switch (timeIndex) {
      case 0:
        mealtime = '아침';
        break;
      case 1:
        mealtime = '점심';
        break;
      case 2:
        mealtime = '저녁';
    }
    print('식사시간은 $mealtime');
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Text(
          mealtime,
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: menuList.length,
          itemBuilder: (context, index) {
            return Text(
              menuList[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            );
          },
        )
      ],
    );
  }
}
