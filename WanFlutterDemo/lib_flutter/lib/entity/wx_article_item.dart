
import 'package:json_annotation/json_annotation.dart';


part 'wx_article_item.g.dart';
@JsonSerializable()
class WXArticleItem {
  WXArticleItem();
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


  factory WXArticleItem.fromJson(Map<String, dynamic> json) => _$WXArticleItemFromJson(json);

  Map<String, dynamic> toJson() => _$WXArticleItemToJson(this);
}
