import 'package:json_annotation/json_annotation.dart';
import 'package:lib_flutter/entity/wx_article_item.dart';
part 'wx_article_data.g.dart';
@JsonSerializable()
class WXArticleData {
  WXArticleData();

  int curPage;
  List<WXArticleItem> datas;

  factory WXArticleData.fromJson(Map<String, dynamic> json) => _$WXArticleDataFromJson(json);
  Map<String, dynamic> toJson() => _$WXArticleDataToJson(this);

}