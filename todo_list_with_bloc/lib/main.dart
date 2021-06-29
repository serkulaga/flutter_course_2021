import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo/todo_bloc.dart';
import 'package:todo_list/pages/splashPage.dart';
import 'package:todo_list/repository/todo_repository.dart';

import 'bloc/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<TodoRepository>(create: (context) => TodoRepository()),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(create: (context) => TodoBloc(todosRepository: RepositoryProvider.of<TodoRepository>(context))..add(TodoLoad()))
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toto list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
