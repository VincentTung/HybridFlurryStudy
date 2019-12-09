
import 'package:json_annotation/json_annotation.dart';


part 'project_item.g.dart';
@JsonSerializable()
class ProjectItem {
  ProjectItem();
  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;

  String link;
  String niceDate;

  num publishTime;
  int superChapterId;
  String superChapterName;

  String title;
  int type;
  int zan;


  factory ProjectItem.fromJson(Map<String, dynamic> json) => _$ProjectItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectItemToJson(this);
}
