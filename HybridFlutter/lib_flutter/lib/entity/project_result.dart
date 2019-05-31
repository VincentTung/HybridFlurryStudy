import 'package:json_annotation/json_annotation.dart';

import 'project_data.dart';
part 'project_result.g.dart';
@JsonSerializable()
class ProjectResult {

  ProjectResult();
  int errorCode;
  String errorMsg;
  
  ProjectData data;

  factory ProjectResult.fromJson(Map<String, dynamic> json) => _$ProjectResultFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectResultToJson(this);




}