import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/services/todoService.dart';

import 'addItemPage.dart';
import '../model/todo_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title, required this.items}) : super(key: key);

  final String title;
  final List<TodoModel> items;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> _items = [];

  @override
  void initState() {
    super.initState();
    _items = widget.items;
  }

  void _add(TodoModel item) {
    setState(() {
      _items.add(item);
      TodoService.store(_items);
    });
  }

  void _remove(TodoModel item) {
    setState(() {
      _items.remove(item);
      TodoService.store(_items);
    });
  }

  void _setSelectec(int index, bool selected) {
    setState(() {
      _items[index].selected = selected;
      TodoService.store(_items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              'Your TODO list:',
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _items[index].selected,
                            onChanged: (value) => _setSelectec(index, value ?? false),
                          ),
                          Text(_items[index].price.toString()),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              _items[index].title,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            onPressed: () => _remove(_items[index]),
                            child: Icon(Icons.delete),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newItem = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemPage()));
          if (newItem != null) {
            _add(newItem);
          }
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
