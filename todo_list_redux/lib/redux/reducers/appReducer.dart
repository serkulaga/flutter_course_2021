import 'package:todo_list/redux/reducers/todoItemsReducer.dart';
import 'package:todo_list/redux/states/appState.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(todoItemsState: todoItemsReducer(state.todoItemsState, action));
}
