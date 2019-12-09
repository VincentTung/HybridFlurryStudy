// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleResult _$ArticleResultFromJson(Map<String, dynamic> json) {
  return ArticleResult()
    ..errorCode = json['errorCode'] as int
    ..errorMsg = json['errorMsg'] as String
    ..data = json['data'] == null
        ? null
        : ArticleData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ArticleResultToJson(ArticleResult instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
      'data': instance.data
    };
