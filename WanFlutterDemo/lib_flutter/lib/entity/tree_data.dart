
import 'package:json_annotation/json_annotation.dart';
import 'package:lib_flutter/entity/tree_item.dart';

part 'tree_data.g.dart';
@JsonSerializable()
class TreeData{
  TreeData();
  List<TreeItem> data;

  factory TreeData.fromJson(Map<String, dynamic> json) => _$TreeDataFromJson(json);

  Map<String, dynamic> toJson() => _$TreeDataToJson(this);
}