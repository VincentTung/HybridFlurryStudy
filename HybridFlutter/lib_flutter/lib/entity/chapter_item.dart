import 'package:json_annotation/json_annotation.dart';


part 'chapter_item.g.dart';
@JsonSerializable()
class ChapterItem {
//  "children": [],
//  "courseId": 13,
//  "id": 408,
//  "name": "鸿洋",
//  "order": 190000,
//  "parentChapterId": 407,
//  "userControlSetTop": false,
//  "visible": 1
  ChapterItem();
  int courseId;
  
  
  int id;
  String name;
  num order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  factory ChapterItem.fromJson(Map<String, dynamic> json) => _$ChapterItemFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterItemToJson(this);
}
