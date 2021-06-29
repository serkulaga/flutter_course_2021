import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/repository/model/todo_model.dart';
import 'package:todo_list/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todosRepository;

  TodoBloc({required this.todosRepository}) : super(TodosLoadInProgress());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is TodoLoad) {
      yield* _mapTodosLoadedToState();
    } else if (event is TodoAdd) {
      yield* _mapTodoAddedToState(event);
    } else if (event is TodoUpdate) {
      yield* _mapTodoUpdatedToState(event);
    } else if (event is TodoDelete) {
      yield* _mapTodoDeletedToState(event);
    } else if (event is ClearSelected) {
      yield* _mapClearSelectedToState();
    } else if (event is TodoSelect) {
      yield* _mapSelectTotoToState(event);
    }
  }

  Stream<TodoState> _mapTodosLoadedToState() async* {
    try {
      yield TodosLoadInProgress();
      final todos = await this.todosRepository.restore();
      await Future.delayed(Duration(seconds: 5));
      yield TodoLoadSuccess(todos);
    } catch (_) {
      yield TodosLoadFailure();
    }
  }

  Stream<TodoState> _mapTodoAddedToState(TodoAdd event) async* {
    if (state is TodoLoadSuccess) {
      final List<TodoModel> updatedTodos =
          List.from((state as TodoLoadSuccess).todos)..add(event.todo);
      yield TodoLoadSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodoState> _mapTodoUpdatedToState(TodoUpdate event) async* {
    if (state is TodoLoadSuccess) {
      final List<TodoModel> updatedTodos =
          (state as TodoLoadSuccess).todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      yield TodoLoadSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodoState> _mapTodoDeletedToState(TodoDelete event) async* {
    if (state is TodoLoadSuccess) {
      final updatedTodos = (state as TodoLoadSuccess)
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();
      yield TodoLoadSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodoState> _mapSelectTotoToState(TodoSelect event) async* {
    if (state is TodoLoadSuccess) {
      final updatedTodo = event.todo.copyWith(selected: !event.todo.selected);
      final List<TodoModel> updatedTodos =
          (state as TodoLoadSuccess).todos.map((todo) {
        return todo.id == event.todo.id ? updatedTodo : todo;
      }).toList();
      yield TodoLoadSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodoState> _mapClearSelectedToState() async* {
    if (state is TodoLoadSuccess) {
      final List<TodoModel> updatedTodos = (state as TodoLoadSuccess)
          .todos
          .where((todo) => !todo.selected)
          .toList();
      yield TodoLoadSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<TodoModel> todos) {
    return todosRepository.store(todos);
  }
}
