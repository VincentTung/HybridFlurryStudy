import 'package:json_annotation/json_annotation.dart';
import 'package:lib_flutter/entity/project_item.dart';

part 'project_data.g.dart';
@JsonSerializable()
class ProjectData {
  ProjectData();

  int curPage;
  List<ProjectItem> datas;

  factory ProjectData.fromJson(Map<String, dynamic> json) => _$ProjectDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectDataToJson(this);

}