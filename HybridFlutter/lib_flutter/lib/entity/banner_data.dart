import 'package:json_annotation/json_annotation.dart';
import 'package:lib_flutter/entity/banner_item.dart';
part 'banner_data.g.dart';
@JsonSerializable()
class BannerData{
  BannerData();
  List<BannerItem> data;

  factory BannerData.fromJson(Map<String, dynamic> json) => _$BannerDataFromJson(json);

  Map<String, dynamic> toJson() => _$BannerDataToJson(this);
}