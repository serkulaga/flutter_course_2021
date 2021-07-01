import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_list/redux/actions/todoItemsThunks.dart';
import 'package:todo_list/redux/states/appState.dart';
import 'package:todo_list/redux/states/todoItemsState.dart';
import 'package:todo_list/screens/homeScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodoItemsState>(
        onInit: (store) {
          store.dispatch(getItems());
        },
        converter: (store) => store.state.todoItemsState,
        builder: (context, todoItemsState) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Todo list. Items: ${todoItemsState.items.length}'),
              ),
              body: todoItemsState.isLoading
                  ? Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/splash_screen.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(child: SizedBox()))
                  : HomeScreen());
        });
  }
}
