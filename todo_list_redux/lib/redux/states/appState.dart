import 'package:flutter/cupertino.dart';
import 'package:todo_list/redux/states/todoItemsState.dart';

@immutable
class AppState {
  final TodoItemsState todoItemsState;

  AppState({required this.todoItemsState});

  factory AppState.initial() {
    return AppState(
      todoItemsState: TodoItemsState.initial(),
    );
  }

  AppState copyWith({TodoItemsState? todoItemsState}) {
    return AppState(todoItemsState: todoItemsState ?? this.todoItemsState);
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppState && todoItemsState == other.todoItemsState;

  @override
  int get hashCode => todoItemsState.hashCode;
}
