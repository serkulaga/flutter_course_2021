// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todoListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoListItem _$TodoListItemFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'name']);
  return TodoListItem(
    id: json['id'] as int? ?? 0,
    name: json['name'] as String? ?? '',
    competed: json['competed'] as bool? ?? false,
    description: json['description'] as String? ?? '',
  );
}

Map<String, dynamic> _$TodoListItemToJson(TodoListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'competed': instance.competed,
      'description': instance.description,
    };
