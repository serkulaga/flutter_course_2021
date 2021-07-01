import 'package:todo_list/redux/actions/todoItemsActions.dart';
import 'package:todo_list/redux/states/todoItemsState.dart';

TodoItemsState todoItemsReducer(TodoItemsState state, dynamic action) {
  if (action is ItemsLoading) {
    return _itemsLoading(state, action);
  } else if (action is ItemsLoaded) {
    return _itemsLoaded(state, action);
  } else if (action is UpdateItems) {
    return _updateItems(state, action);
  }
  return state;
}

TodoItemsState _itemsLoading(TodoItemsState state, ItemsLoading action) {
  return state.copyWith(isLoading: action.isLoading);
}

TodoItemsState _itemsLoaded(TodoItemsState state, ItemsLoaded action) {
  return state.copyWith(items: action.items, isLoading: false);
}

TodoItemsState _updateItems(TodoItemsState state, UpdateItems action) {
  return state.copyWith(items: action.items);
}
