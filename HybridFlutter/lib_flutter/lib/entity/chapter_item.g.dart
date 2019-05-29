// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterItem _$ChapterItemFromJson(Map<String, dynamic> json) {
  return ChapterItem()
    ..courseId = json['courseId'] as int
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..order = json['order'] as num
    ..parentChapterId = json['parentChapterId'] as int
    ..userControlSetTop = json['userControlSetTop'] as bool
    ..visible = json['visible'] as int;
}

Map<String, dynamic> _$ChapterItemToJson(ChapterItem instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible
    };
