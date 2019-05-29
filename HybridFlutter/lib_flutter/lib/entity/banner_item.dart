import 'package:json_annotation/json_annotation.dart';


//  "desc": "Android高级进阶直播课免费学习\r\n",
//  "id": 22,
//  "imagePath": "https://wanandroid.com/blogimgs/c3615a24-79ef-45c9-9ae6-5adfe5437d32.jpeg",
//  "isVisible": 1,
//  "order": 0,
//  "title": "Android高级进阶直播课免费学习",
//  "type": 0,
//  "url": "https://url.163.com/4bj"
part 'banner_item.g.dart';
@JsonSerializable()
class BannerItem {
  BannerItem();

  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  factory BannerItem.fromJson(Map<String, dynamic> json) => _$BannerItemFromJson(json);

  Map<String, dynamic> toJson() => _$BannerItemToJson(this);
}
