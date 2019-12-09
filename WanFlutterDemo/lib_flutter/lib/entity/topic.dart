
import 'package:json_annotation/json_annotation.dart';
import 'package:lib_flutter/entity/vnode.dart';
import 'package:lib_flutter/entity/user.dart';
// user.g.dart 将在我们运行生成命令后自动生成
part 'topic.g.dart';


@JsonSerializable()
class Topic {
  String last_reply_by;
  num last_touched;
  String title;
  String url;
  num created;
  String content;
  String content_rendered;
  num last_modified;
  int replies;
  int id;
  VNode node;
  User member;

  Topic();
  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}
