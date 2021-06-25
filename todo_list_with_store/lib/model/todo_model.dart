import 'package:json_annotation/json_annotation.dart';
part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  final String title;
  final num price; 
  bool selected;

  TodoModel({this.title: "", this.price: 0, this.selected: false});

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}

@JsonSerializable()
class TodoModelList {
  final List<TodoModel> items;
  final DateTime stotedDate;
  TodoModelList(this.items, this.stotedDate);

  factory TodoModelList.fromJson(Map<String, dynamic> json) => _$TodoModelListFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelListToJson(this);
}