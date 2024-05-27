import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
 const Setting({super.key});

 @override
 State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
 @override
 Widget build(BuildContext context) {
  double myHeight = MediaQuery.of(context).size.height;
  double myWidth = MediaQuery.of(context).size.width;

  return SafeArea(
    child: Scaffold(
      backgroundColor: Color.fromARGB(255, 113, 113, 192),
      body: Container(
        height: myHeight,
        width: myWidth,
        child: Center(
          child: Text('Work in progress...', style: TextStyle(color: Colors.grey, fontSize: 25)),
        )
      )
    ),
  );
 }
}