
import 'package:json_annotation/json_annotation.dart';
import 'package:lib_flutter/entity/user.dart';
part 'reply.g.dart';
@JsonSerializable()
class Reply {
  User member;
  num created;
  num topic_id;
  String content;
  String content_rendered;
  num last_modified;
  num member_id;
  num id;
  Reply();

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyToJson(this);

}