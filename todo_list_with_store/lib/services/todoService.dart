import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/todo_model.dart';

class TodoService {

  static String _key = "tudo";

  static store(List<TodoModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final model = TodoModelList(items, DateTime.now());
    final jsonString = json.encode(model.toJson());    
    prefs.setString(_key, jsonString);
  }

  static Future<List<TodoModel>> restore() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if(jsonString != null){
      final model = TodoModelList.fromJson(json.decode(jsonString));
      return model.items;
    } 

    return [];
  }
}