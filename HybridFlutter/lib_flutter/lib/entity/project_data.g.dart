// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectData _$ProjectDataFromJson(Map<String, dynamic> json) {
  return ProjectData()
    ..curPage = json['curPage'] as int
    ..datas = (json['datas'] as List)
        ?.map((e) =>
            e == null ? null : ProjectItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ProjectDataToJson(ProjectData instance) =>
    <String, dynamic>{'curPage': instance.curPage, 'datas': instance.datas};
