// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vnode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VNode _$VNodeFromJson(Map<String, dynamic> json) {
  return VNode()
    ..name = json['name'] as String
    ..avatar_large = json['avatar_large'] as String
    ..avatar_normal = json['avatar_normal'] as String
    ..avatar_mini = json['avatar_mini'] as String
    ..title = json['title'] as String
    ..url = json['url'] as String
    ..topics = json['topics'] as int
    ..footer = json['footer'] as String
    ..header = json['header'] as String
    ..title_alternative = json['title_alternative'] as String
    ..stars = json['stars'] as int
    ..id = json['id'] as int
    ..parent_node_name = json['parent_node_name'] as String;
}

Map<String, dynamic> _$VNodeToJson(VNode instance) => <String, dynamic>{
      'name': instance.name,
      'avatar_large': instance.avatar_large,
      'avatar_normal': instance.avatar_normal,
      'avatar_mini': instance.avatar_mini,
      'title': instance.title,
      'url': instance.url,
      'topics': instance.topics,
      'footer': instance.footer,
      'header': instance.header,
      'title_alternative': instance.title_alternative,
      'stars': instance.stars,
      'id': instance.id,
      'parent_node_name': instance.parent_node_name
    };
