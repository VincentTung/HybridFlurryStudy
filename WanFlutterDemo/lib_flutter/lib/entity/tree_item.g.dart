// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeItem _$TreeItemFromJson(Map<String, dynamic> json) {
  return TreeItem()
    ..children = (json['children'] as List)
        ?.map((e) =>
            e == null ? null : TreeItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..courseId = json['courseId'] as int
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..order = json['order'] as int
    ..parentChapterId = json['parentChapterId'] as int
    ..userControlSetTop = json['userControlSetTop'] as bool
    ..visible = json['visible'] as int;
}

Map<String, dynamic> _$TreeItemToJson(TreeItem instance) => <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible
    };
