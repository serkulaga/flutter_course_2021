import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:todo_list/appConstants.dart';
import 'package:todo_list/helpers/jsonHelper.dart';
import 'package:todo_list/models/todoListItem.dart';
import 'package:todo_list/redux/actions/todoItemsActions.dart';
import 'package:todo_list/redux/states/appState.dart';
import 'package:todo_list/services/storageService.dart';

ThunkAction<AppState> getItems() {
  return (Store<AppState> store) async {
    store.dispatch(ItemsLoading(true));

    await Future.delayed(Duration(seconds: 5));

    var todoItemsJson = await StorageService.getValue(PreferenceKeys.items);

    var items = <TodoListItem>[];
    if (todoItemsJson != null && todoItemsJson.length > 0) {
      var itemsMap = jsonDecode(todoItemsJson);
      items = JsonHelper.listFromJson(itemsMap);
    }

    store.dispatch(ItemsLoaded(items));
  };
}

ThunkAction<AppState> addItem(TodoListItem item) {
  return (Store<AppState> store) async {
    var items = List<TodoListItem>.from(store.state.todoItemsState.items);
    var lastItem = items.length != 0 ? items.reduce((currentItem, nextItem) => currentItem.id! > nextItem.id! ? currentItem : nextItem) : null;
    item.id = lastItem == null ? 1 : lastItem.id! + 1;
    items.add(item);

    try {
      await _updatItemsInPreference(items);
      await Future.delayed(Duration(seconds: 3));
    } on SetValueException catch (e) {}

    store.dispatch(UpdateItems(items));
  };
}

ThunkAction<AppState> updateItem(TodoListItem item) {
  return (Store<AppState> store) async {
    var items = store.state.todoItemsState.items.map((x) => x.id == item.id ? item : x).toList();

    try {
      await _updatItemsInPreference(items);
      await Future.delayed(Duration(seconds: 3));
    } on SetValueException catch (e) {}

    store.dispatch(UpdateItems(items));
  };
}

ThunkAction<AppState> removeItem(TodoListItem item) {
  return (Store<AppState> store) async {
    var items = store.state.todoItemsState.items.where((x) => x.id != item.id).toList();

    try {
      await _updatItemsInPreference(items);
      await Future.delayed(Duration(seconds: 3));
    } on SetValueException catch (e) {}

    store.dispatch(UpdateItems(items));
  };
}

Future<void> _updatItemsInPreference(List<TodoListItem> items) async {
  var itemsMap = JsonHelper.listToJson(items);
  var itemsJson = json.encode(itemsMap);
  await StorageService.setValue(PreferenceKeys.items, itemsJson);
}
