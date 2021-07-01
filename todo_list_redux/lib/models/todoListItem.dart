import 'package:json_annotation/json_annotation.dart';
part 'todoListItem.g.dart';

@JsonSerializable()
class TodoListItem {
  @JsonKey(defaultValue: 0, required: true)
  int? id;

  @JsonKey(defaultValue: "", required: true)
  String? name;

  @JsonKey(defaultValue: false)
  bool competed;

  @JsonKey(defaultValue: "")
  String? description;

  TodoListItem({required this.id, this.name, this.competed = false, this.description});

  factory TodoListItem.fromJson(Map<String, dynamic> json) => _$TodoListItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListItemToJson(this);
}
