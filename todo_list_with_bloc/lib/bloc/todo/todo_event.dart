part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoLoad extends TodoEvent {}

class TodoAdd extends TodoEvent {
  final TodoModel todo;

  const TodoAdd(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoUpdate extends TodoEvent {
  final TodoModel todo;

  const TodoUpdate(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoDelete extends TodoEvent {
  final TodoModel todo;

  const TodoDelete(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoSelect extends TodoEvent {
  final TodoModel todo;

  const TodoSelect(this.todo);

  @override
  List<Object> get props => [todo];
}

class ClearSelected extends TodoEvent {}