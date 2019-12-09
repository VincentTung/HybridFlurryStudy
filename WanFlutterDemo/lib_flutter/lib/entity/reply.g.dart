// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reply _$ReplyFromJson(Map<String, dynamic> json) {
  return Reply()
    ..member = json['member'] == null
        ? null
        : User.fromJson(json['member'] as Map<String, dynamic>)
    ..created = json['created'] as num
    ..topic_id = json['topic_id'] as num
    ..content = json['content'] as String
    ..content_rendered = json['content_rendered'] as String
    ..last_modified = json['last_modified'] as num
    ..member_id = json['member_id'] as num
    ..id = json['id'] as num;
}

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'member': instance.member,
      'created': instance.created,
      'topic_id': instance.topic_id,
      'content': instance.content,
      'content_rendered': instance.content_rendered,
      'last_modified': instance.last_modified,
      'member_id': instance.member_id,
      'id': instance.id
    };
