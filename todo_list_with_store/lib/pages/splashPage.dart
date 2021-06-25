import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/services/todoService.dart';

import 'homePage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final items = await TodoService.restore();
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(title: "Todo List", items: items)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Splash page")));
  }
}
