
//"avatar_large": "//cdn.v2ex.com/navatar/c4ca/4238/1_large.png?m=1494924246",
//"name": "babel",
//"avatar_normal": "//cdn.v2ex.com/navatar/c4ca/4238/1_normal.png?m=1494924246",
//"title": "Project Babel",
//"url": "https://www.v2ex.com/go/babel",
//"topics": 1122,
//"footer": "V2EX 基于 Project Babel 驱动。Project Babel 是用 Python 语言写成的，运行于 Google App Engine 云计算平台上的社区软件。Project Babel 当前开发分支 2.5。最新版本可以从 <a href=\"http://github.com/livid/v2ex\" target=\"_blank\">GitHub</a> 获取。",
//"header": "Project Babel - 帮助你在云平台上搭建自己的社区",
//"title_alternative": "Project Babel",
//"avatar_mini": "//cdn.v2ex.com/navatar/c4ca/4238/1_mini.png?m=1494924246",
//"stars": 386,
//"root": false,
//"id": 1,
//"parent_node_name": "v2ex"
//}
import 'package:json_annotation/json_annotation.dart';
part 'vnode.g.dart';

@JsonSerializable()
class VNode{

  String name;
  String avatar_large;
  String avatar_normal;
  String avatar_mini;
  String title;
  String url;
  int topics;
  String footer;
  String header;
  String title_alternative;
  int stars;
  int id;
  String parent_node_name;

  VNode();
  factory VNode.fromJson(Map<String, dynamic> json) => _$VNodeFromJson(json);
  Map<String, dynamic> toJson() => _$VNodeToJson(this);
}