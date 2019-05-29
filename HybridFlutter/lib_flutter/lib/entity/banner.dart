import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';
@JsonSerializable()
class Banner{
  Banner();
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);
  Map<String, dynamic> toJson() => _$BannerToJson(this);
//  "desc": "Android高级进阶直播课免费学习\r\n",
//  "id": 22,
//  "imagePath": "https://wanandroid.com/blogimgs/c3615a24-79ef-45c9-9ae6-5adfe5437d32.jpeg",
//  "isVisible": 1,
//  "order": 0,
//  "title": "Android高级进阶直播课免费学习",
//  "type": 0,
//  "url": "https://url.163.com/4bj"
}