// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectResult _$ProjectResultFromJson(Map<String, dynamic> json) {
  return ProjectResult()
    ..errorCode = json['errorCode'] as int
    ..errorMsg = json['errorMsg'] as String
    ..data = json['data'];
}

Map<String, dynamic> _$ProjectResultToJson(ProjectResult instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'data': instance.data
    };
