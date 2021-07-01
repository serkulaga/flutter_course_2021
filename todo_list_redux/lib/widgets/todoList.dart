import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_list/models/todoListItem.dart';
import 'package:todo_list/redux/actions/todoItemsThunks.dart';
import 'package:todo_list/redux/states/appState.dart';
import 'package:todo_list/widgets/addUpdateTodoListItem.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: StoreConnector<AppState, _TodoListViewModel>(
            converter: (store) => _TodoListViewModel.fromStore(store),
            builder: (context, todoListViewModel) {
              return ListView.builder(
                  itemCount: todoListViewModel.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Checkbox(
                                value: todoListViewModel.items[index].competed,
                                onChanged: (value) {
                                  todoListViewModel.update(TodoListItem(
                                      id: todoListViewModel.items[index].id,
                                      competed: value ?? false,
                                      name: todoListViewModel.items[index].name,
                                      description: todoListViewModel.items[index].description));
                                },
                              ),
                              title: todoListViewModel.items[index].competed
                                  ? Text('${todoListViewModel.items[index].name}',
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red, decoration: TextDecoration.lineThrough))
                                  : Text('${todoListViewModel.items[index].name}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                              subtitle: todoListViewModel.items[index].competed
                                  ? Text('${todoListViewModel.items[index].description}',
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red, decoration: TextDecoration.lineThrough))
                                  : Text('${todoListViewModel.items[index].description}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                              onTap: () {
                                todoListViewModel.update(TodoListItem(
                                    id: todoListViewModel.items[index].id,
                                    competed: !todoListViewModel.items[index].competed,
                                    name: todoListViewModel.items[index].name,
                                    description: todoListViewModel.items[index].description));
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddUpdateTodoListItem(
                                                item: TodoListItem(
                                                    id: todoListViewModel.items[index].id,
                                                    competed: todoListViewModel.items[index].competed,
                                                    name: todoListViewModel.items[index].name,
                                                    description: todoListViewModel.items[index].description),
                                                isUpdateAction: true,
                                                addItem: todoListViewModel.add,
                                                updateItem: todoListViewModel.update)),
                                      );
                                    },
                                    child: Icon(Icons.edit),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () async {
                                      await todoListViewModel.remove(todoListViewModel.items[index]);
                                    },
                                    child: Icon(Icons.delete),
                                  ),
                                  SizedBox(width: 8)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}

class _TodoListViewModel {
  final List<TodoListItem> items;
  final Function(TodoListItem item) add;
  final Function(TodoListItem item) update;
  final Function(TodoListItem item) remove;

  _TodoListViewModel({required this.items, required this.add, required this.update, required this.remove});

  static _TodoListViewModel fromStore(Store<AppState> store) {
    return _TodoListViewModel(
        items: store.state.todoItemsState.items,
        add: (item) {
          store.dispatch(addItem(item));
        },
        update: (item) {
          store.dispatch(updateItem(item));
        },
        remove: (item) {
          store.dispatch(removeItem(item));
        });
  }
}
