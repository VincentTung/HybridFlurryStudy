
import 'package:json_annotation/json_annotation.dart';

part 'tree_item.g.dart';
@JsonSerializable()
class TreeItem {
  TreeItem();
  List<TreeItem> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  factory TreeItem.fromJson(Map<String, dynamic> json) => _$TreeItemFromJson(json);

  Map<String, dynamic> toJson() => _$TreeItemToJson(this);
//
//  "children": [],
//  "courseId": 13,
//  "id": 198,
//  "name": "基础概念",
//  "order": 5002,
//  "parentChapterId": 167,
//  "userControlSetTop": false,
//  "visible": 1
}
