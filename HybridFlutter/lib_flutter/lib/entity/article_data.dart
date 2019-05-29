import 'package:lib_flutter/entity/article.dart';

import 'package:json_annotation/json_annotation.dart';
part 'article_data.g.dart';
@JsonSerializable()
class ArticleData {
  ArticleData();

  int curPage;
  List<Article> datas;

  factory ArticleData.fromJson(Map<String, dynamic> json) => _$ArticleDataFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleDataToJson(this);

}
