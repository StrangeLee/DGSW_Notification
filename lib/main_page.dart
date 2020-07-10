import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text(
              'DGSW Notification',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }
}
