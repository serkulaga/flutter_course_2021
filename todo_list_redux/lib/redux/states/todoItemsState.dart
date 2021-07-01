import 'package:flutter/material.dart';
import 'package:todo_list/models/todoListItem.dart';

@immutable
class TodoItemsState {
  final bool isLoading;
  final bool loginError;
  final List<TodoListItem> items;

  TodoItemsState({
    required this.isLoading,
    required this.loginError,
    required this.items,
  });

  factory TodoItemsState.initial() {
    return new TodoItemsState(isLoading: false, loginError: false, items: <TodoListItem>[]);
  }

  TodoItemsState copyWith({bool? isLoading, bool? loginError, List<TodoListItem>? items}) {
    return new TodoItemsState(isLoading: isLoading ?? this.isLoading, loginError: loginError ?? this.loginError, items: items ?? this.items);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoItemsState && runtimeType == other.runtimeType && isLoading == other.isLoading && loginError == other.loginError && items == other.items;

  @override
  int get hashCode => isLoading.hashCode ^ loginError.hashCode ^ items.hashCode;
}
