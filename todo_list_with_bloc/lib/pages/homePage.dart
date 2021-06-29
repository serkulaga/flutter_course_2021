import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo/todo_bloc.dart';
import 'addItemPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if(state is TodoLoadSuccess){
             return Text("TODO list. Count: " + state.todos.length.toString() + " Selected: " + state.todos.where((e)=> e.selected).length.toString());
          }
          return Text("Loading TODO ...");
        },
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text('Your TODO list:'),
            Expanded(
              child:
                  BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
                if (state is TodoLoadSuccess) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.todos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: state.todos[index].selected,
                                onChanged: (value) =>
                                    BlocProvider.of<TodoBloc>(context)
                                        .add(TodoSelect(state.todos[index])),
                              ),
                              Text(state.todos[index].price.toString()),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: Text(state.todos[index].title)),
                              SizedBox(width: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.blue,
                                ),
                                onPressed: () =>
                                    BlocProvider.of<TodoBloc>(context)
                                        .add(TodoDelete(state.todos[index])),
                                child: Icon(Icons.delete),
                              )
                            ],
                          ),
                        );
                      });
                }
                if (state is TodosLoadFailure) {
                  return Center(
                    child: Text("error"),
                  );
                } else
                  return Center(child: CircularProgressIndicator());
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newItem = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddItemPage()));
          if (newItem != null) {
            BlocProvider.of<TodoBloc>(context).add(TodoAdd(newItem));
          }
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
