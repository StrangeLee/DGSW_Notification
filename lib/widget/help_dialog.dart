import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class HelpDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: Colors.white,
          width: 3.0,
        )
      ),
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    final Color fontColor = Colors.white;
    final String myEmail = 'kevin.sangha.lee@gmail.com';
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '프로그레스바는 오전 8시 ~ 오후 9시를 기준으로 카운트 합니다. '
              '이 앱은 대구소프트웨어고등학교 3기 이상하 학생이 flutter를 이용해 제작하였습니다. '
              '오류 또는 문의 사항은 하단 email로 문의하시길 바랍니다. '
              'UI/UX 고쳐 주세요 같은 질문도 받습니다만 디자인 직접 구상해서 보내주세요.'
              '메일 양식은 제목 정도만 [대소고 알리미] ~~~~문의(학반학번) 정로만 해주세요.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15.0,
                color: fontColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: InkWell(
                onTap: () => getTextToClipboard(context, myEmail),
                child: Text(
                  myEmail,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getTextToClipboard(BuildContext context, String text) {
    Clipboard.setData(
        ClipboardData(text: text)
    );
    Toast.show('이메일이 클립보드에 복사되었습니다.', context);
  }
}
