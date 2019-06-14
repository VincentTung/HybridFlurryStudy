
import 'package:json_annotation/json_annotation.dart';
part 'article.g.dart';
@JsonSerializable()
class Article {
  Article();
  String title;
  int type;
  int userId;
  int visible;
  int zan;
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
  String origin;
  String prefix;
  String projectLink;
  num publishTime;
  int superChapterId;
  String superChapterName;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

}
