import 'package:todo_list/models/todoListItem.dart';

class JsonHelper{
  static Map<String, dynamic> listToJson<T>(List<T> items) =>
    <String, dynamic>{
      'items': items
    };

    static List<TodoListItem> listFromJson(Map<String, dynamic> json) {
      return json['items'] != null ? List<TodoListItem>.from(json["items"].map((itemJson) => TodoListItem.fromJson(itemJson))) : [];
    }
}