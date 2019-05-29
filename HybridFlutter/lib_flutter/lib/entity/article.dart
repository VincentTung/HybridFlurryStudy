
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

//
//"apkLink": "",
//"author": "ixuea",
//"chapterId": 328,
//"chapterName": "网络&amp;文件下载",
//"collect": false,
//"courseId": 13,
//"desc": "Android Downloader是一个开源的多线程，多任务下载框架",
//"envelopePic": "https://wanandroid.com/blogimgs/ae7393e6-a5ba-4721-aeaa-7382c0da7d03.png",
//"fresh": true,
//"id": 8509,
//"link": "http://www.wanandroid.com/blog/show/2585",
//"niceDate": "16小时前",
//"origin": "",
//"prefix": "",
//"projectLink": "https://github.com/ixuea/AndroidDownloader",
//"publishTime": 1559045113000,
//"superChapterId": 294,
//"superChapterName": "开源项目主Tab",
//"tags": [
//{
//"name": "项目",
//"url": "/project/list/1?cid=328"
//}
//],
//"title": "Android Downloader是一个开源的多线程，多任务下载框架",
//"type": 0,
//"userId": -1,
//"visible": 1,
//"zan": 0
}
