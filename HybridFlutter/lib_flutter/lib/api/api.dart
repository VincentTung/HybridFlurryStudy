import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lib_flutter/cfg/url.dart';
import 'package:lib_flutter/entity/article_data.dart';
import 'package:lib_flutter/entity/banner_data.dart';
import 'package:lib_flutter/net/httputil.dart';

class ApiHelper {
  ///banner信息
  static Future<BannerData> getBanner() async {
    Response response = await HttpUtil.getInstance().get(URL_BANNER);
    BannerData bannerData =
        BannerData.fromJson(json.decode(response.toString()));
    return bannerData;
  }
  ///获取首页文章
  static Future<ArticleData> getArticleData(int page) async{
    Response response = await HttpUtil.getInstance().get("https://www.wanandroid.com/article/list/${page}/json");
    ArticleData bannerData =
    ArticleData.fromJson(json.decode(response.data["data"].toString()));
    return bannerData;
  }
}
