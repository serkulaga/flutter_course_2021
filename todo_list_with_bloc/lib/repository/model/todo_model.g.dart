// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) {
  return TodoModel(
    title: json['title'] as String,
    price: json['price'] as num,
    selected: json['selected'] as bool,
    id: json['id'] as String?,
  );
}

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'selected': instance.selected,
    };

TodoModelList _$TodoModelListFromJson(Map<String, dynamic> json) {
  return TodoModelList(
    (json['items'] as List<dynamic>)
        .map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    DateTime.parse(json['stotedDate'] as String),
  );
}

Map<String, dynamic> _$TodoModelListToJson(TodoModelList instance) =>
    <String, dynamic>{
      'items': instance.items,
      'stotedDate': instance.stotedDate.toIso8601String(),
    };
