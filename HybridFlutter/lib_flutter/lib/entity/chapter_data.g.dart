// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterData _$ChapterDataFromJson(Map<String, dynamic> json) {
  return ChapterData()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ChapterItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ChapterDataToJson(ChapterData instance) =>
    <String, dynamic>{'data': instance.data};
