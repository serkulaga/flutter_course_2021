import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_list/models/todoListItem.dart';
import 'package:todo_list/redux/actions/todoItemsThunks.dart';
import 'package:todo_list/redux/states/appState.dart';
import 'package:todo_list/widgets/addUpdateTodoListItem.dart';
import 'package:todo_list/widgets/todoList.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _HomeScreenViewModel>(
        converter: (store) => _HomeScreenViewModel.fromStore(store),
        builder: (context, homeScreenViewModel) {
          return Container(
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 16, left: 8.0, right: 8.0, bottom: 0),
                  child: TodoList(),
                )),
                SizedBox(height: 8.0),
                FloatingActionButton(
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddUpdateTodoListItem(
                                item: TodoListItem(id: 0, competed: false, name: "", description: ""),
                                isUpdateAction: false,
                                addItem: homeScreenViewModel.add,
                                updateItem: homeScreenViewModel.update)));
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                )
              ],
            ),
          );
        });
  }
}

class _HomeScreenViewModel {
  final Function(TodoListItem item) add;
  final Function(TodoListItem item) update;

  _HomeScreenViewModel({required this.add, required this.update});

  static _HomeScreenViewModel fromStore(Store<AppState> store) {
    return _HomeScreenViewModel(add: (item) {
      store.dispatch(addItem(item));
    }, update: (item) {
      store.dispatch(updateItem(item));
    });
  }
}
