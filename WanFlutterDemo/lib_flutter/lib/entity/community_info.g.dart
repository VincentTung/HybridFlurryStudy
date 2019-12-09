// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityInfo _$CommunityInfoFromJson(Map<String, dynamic> json) {
  return CommunityInfo()
    ..title = json['title'] as String
    ..slogan = json['slogan'] as String
    ..description = json['description'] as String
    ..domain = json['domain'] as String;
}

Map<String, dynamic> _$CommunityInfoToJson(CommunityInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'slogan': instance.slogan,
      'description': instance.description,
      'domain': instance.domain
    };
