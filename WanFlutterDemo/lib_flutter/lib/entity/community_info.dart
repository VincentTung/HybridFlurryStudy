
import 'package:json_annotation/json_annotation.dart';
part 'community_info.g.dart';
@JsonSerializable()
class CommunityInfo{

  String title;
  String slogan;
  String description;
  String domain;
  CommunityInfo();
  factory CommunityInfo.fromJson(Map<String, dynamic> json) => _$CommunityInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityInfoToJson(this);
}