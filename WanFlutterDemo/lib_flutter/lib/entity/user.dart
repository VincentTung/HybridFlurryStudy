//{
//"username": "tension2012",
//"website": "",
//"github": "",
//"psn": "",
//"avatar_normal": "//cdn.v2ex.com/avatar/4b86/f030/48478_mini.png?m=1411312797",
//"bio": "",
//"url": "https://www.v2ex.com/u/tension2012",
//"tagline": "",
//"twitter": "",
//"created": 1383308738,
//"status": "found",
//"avatar_large": "//cdn.v2ex.com/avatar/4b86/f030/48478_mini.png?m=1411312797",
//"avatar_mini": "//cdn.v2ex.com/avatar/4b86/f030/48478_mini.png?m=1411312797",
//"location": "杭州",
//"btc": "",
//"id": 48478
//}
import 'package:json_annotation/json_annotation.dart';
// user.g.dart 将在我们运行生成命令后自动生成
part 'user.g.dart';
@JsonSerializable()
class User{
  String username;
  String website;
  String github;
  String psn;
  String avatar_normal;
  String avatar_large;
  String avatar_mini;
  String location;
  String btc;
  int id;
  String bio;
  String url;
  String tagline;
  String twitter;
  num created;
  String status;

  User();
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}