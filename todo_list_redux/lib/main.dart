import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:todo_list/redux/reducers/appReducer.dart';
import 'package:todo_list/redux/states/appState.dart';
import 'package:todo_list/screens/splashScreen.dart';

import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(appReducer, initialState: AppState.initial(), middleware: [thunkMiddleware]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo list',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StoreProvider(store: store, child: SplashScreen()));
  }
}
