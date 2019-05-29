// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wx_article_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WXArticleData _$WXArticleDataFromJson(Map<String, dynamic> json) {
  return WXArticleData()
    ..curPage = json['curPage'] as int
    ..datas = (json['datas'] as List)
        ?.map((e) => e == null
            ? null
            : WXArticleItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$WXArticleDataToJson(WXArticleData instance) =>
    <String, dynamic>{'curPage': instance.curPage, 'datas': instance.datas};
