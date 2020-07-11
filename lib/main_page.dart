import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // map data 를 구분하기 위한 키워드
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
    super.initState();
    todayDate = DateFormat('yyyyMMdd').format(now);
    mealsList = getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backPress,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              mealsMenuBox(mealsList),
            ],
          ),
        ),
      ),
    );
  }

  // open api 에서 데이터 받아오기
  Future<List<dynamic>> getData() async {
    const defaultUri = 'https://open.neis.go.kr/hub/mealServiceDietInfo?Key=11dfd3b3e3e248db9b75145834995a25&Type=json&pIndex=1&pSize=100&ATPT_OFCDC_SC_CODE=D10&SD_SCHUL_CODE=7240393&MLSV_YMD=';

    http.Response response = await http.get(
      Uri.encodeFull(defaultUri + todayDate),
    );

    // 급식 없는날 Exception 처리, 급식 없는 날과 있는 날의 Api response 값의 json 형태가 다르기 때문에 이렇게 처리
    if (response.body == '{"RESULT":{"CODE":"INFO-200","MESSAGE":"해당하는 데이터가 없습니다."}}') {
      return null;
    } else {
      Map<String, dynamic> map = jsonDecode(response.body);
      List<dynamic> data = map["mealServiceDietInfo"];
      List<dynamic> meals = data[1]['row'];

      return meals;
    }
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

  // 급식 식단 보여주는 위젯, 급식이 없는날 Exception 처리함. 보강 필요할 듯
  Widget mealsMenuBox(Future<List<dynamic>> mealsData) {
    if (mealsData == null) {
      return Center(
        child: Text(
          '오늘은 급식이 없나보군요 ( ｯ◕ ܫ◕)ｯ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      );
    } else {
      return Center(
        child: FutureBuilder(
          future: mealsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              print(data.length);
              return Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  )
                ),
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      mealsList = getData();
                    });
                    return mealsList;
                  },
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var subData = data[index][mapString].toString().split('<br/>');
                        return menuListView(subData, index);
                      }
                  ),
                ),
              );
            } else if (snapshot.hasError) { // Exception 처리...
              print(snapshot.error.toString());
              return Text(
                '오류가 있나보군요... 죄송합니당ㅠㅠ\n( ˃̣̣̥᷄⌓˂̣̣̥᷅ )',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),
              );
            }
            return CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: new AlwaysStoppedAnimation(Colors.lightBlue),
            );
          },
        ),
      );
    }
  }
}
