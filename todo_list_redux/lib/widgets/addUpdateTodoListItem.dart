import 'package:flutter/material.dart';
import 'package:todo_list/models/todoListItem.dart';

class AddUpdateTodoListItem extends StatelessWidget {
  final TodoListItem item;
  final bool isUpdateAction;

  final Function(TodoListItem) addItem;
  final Function(TodoListItem) updateItem;

  AddUpdateTodoListItem({Key? key, required this.item, required this.isUpdateAction, required this.addItem, required this.updateItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: item.name);
    final descriptionController = TextEditingController(text: item.description);

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 32.0),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Name"),
              )),
          SizedBox(width: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Description"),
            ),
          ),
          SizedBox(width: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () async {
                  item.name = nameController.text;
                  item.description = descriptionController.text;
                  isUpdateAction ? await updateItem(item) : await addItem(item);
                  Navigator.pop(context);
                },
                child: Text(isUpdateAction ? "Update item" : "Add item"),
                style: TextButton.styleFrom(textStyle: TextStyle(fontSize: 20))),
          )
        ],
      ),
    );
  }
}
