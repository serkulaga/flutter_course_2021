import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel extends Equatable {
  final String id;
  final String title;
  final num price;
  final bool selected;

  TodoModel({this.title: "", this.price: 0, this.selected: false, String? id})
      : this.id = id ?? Uuid().v1();

  TodoModel copyWith({String? title, num? price, bool? selected}) {
    return TodoModel(
        title: title ?? this.title,
        price: price ?? this.price,
        selected: selected ?? this.selected,
        id: this.id);
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  @override
  List<Object> get props => [title, price, selected];
}

@JsonSerializable()
class TodoModelList {
  final List<TodoModel> items;
  final DateTime stotedDate;
  TodoModelList(this.items, this.stotedDate);

  factory TodoModelList.fromJson(Map<String, dynamic> json) =>
      _$TodoModelListFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelListToJson(this);
}
