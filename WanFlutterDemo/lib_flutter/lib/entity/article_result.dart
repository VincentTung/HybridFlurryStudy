import 'package:json_annotation/json_annotation.dart';
import 'package:lib_flutter/entity/article_data.dart';
part 'article_result.g.dart';
@JsonSerializable()
class ArticleResult {

  ArticleResult();
  int errorCode;
  String errorMsg;
  
  ArticleData data;

  factory ArticleResult.fromJson(Map<String, dynamic> json) => _$ArticleResultFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleResultToJson(this);




}