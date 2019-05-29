// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeData _$TreeDataFromJson(Map<String, dynamic> json) {
  return TreeData()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : TreeItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TreeDataToJson(TreeData instance) =>
    <String, dynamic>{'data': instance.data};
