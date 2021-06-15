import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/model/todo_model_v1.dart';

import 'model/todo_model_v2.dart';
import 'model/todo_model_v3.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //List<TodoModel> _items = [];

  void _incrementCounter() {
    
    List<TodoModelV1> items1 = [];
    final model1 = new TodoModelV1();
    model1.price = 10;
    model1.selected = false;
    model1.title = "new";
    items1.add(model1);


    List<TodoModelV2> items2 = [];
    items2.add(new TodoModelV2("new", 10, false));


    List<TodoModelV3> items3 = [];
    items3.add(new TodoModelV3(price: 10, title: "new"));


    setState(() {
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
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
