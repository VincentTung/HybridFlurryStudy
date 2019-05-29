import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lib_flutter/cfg/url.dart';
import 'package:lib_flutter/entity/article_data.dart';
import 'package:lib_flutter/entity/banner_data.dart';
import 'package:lib_flutter/entity/chapter_data.dart';
import 'package:lib_flutter/entity/project_data.dart';
import 'package:lib_flutter/entity/tree_data.dart';
import 'package:lib_flutter/entity/wx_article_data.dart';
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
  static Future<ArticleData> getArticleData(int page) async {
    Response response = await HttpUtil.getInstance()
        .get("https://www.wanandroid.com/article/list/${page}/json");
    String data = response.data["data"].toString();
    ArticleData bannerData = ArticleData.fromJson(json.decode(data));
    return bannerData;
  }

  ///知识体系
  static Future<TreeData> getTreeData() async {
    Response response = await HttpUtil.getInstance().get(URL_TREE);
    TreeData treeData = TreeData.fromJson(json.decode(response.toString()));
    return treeData;
  }

  ///获取首页文章
  static Future<ArticleData> getArticleDataUnderTree(int page, int id) async {
    Map<String, dynamic> params = new Map();
    params["cid"] = id;
    Response response = await HttpUtil.getInstance().get(
        "https://www.wanandroid.com/article/list/${page}/json",
        data: params);
    String data = response.data["data"].toString();
    ArticleData bannerData = ArticleData.fromJson(json.decode(data));
    return bannerData;
  }

  ///获取公众号tab
  static Future<ChapterData> getChapterData() async {
    Response response = await HttpUtil.getInstance().get(URL_CHAPTER);
    ChapterData bannerData =
        ChapterData.fromJson(json.decode(response.toString()));
    return bannerData;
  }

  ///公众号文章
  static Future<WXArticleData> getWXArticleData(int id, int page) async {
    Response response = await HttpUtil.getInstance()
        .get("https://wanandroid.com/wxarticle/list/$id/$page/json");
    String data = response.data["data"].toString();
    WXArticleData bannerData = WXArticleData.fromJson(json.decode(data));
    return bannerData;
  }

  ///项目分类
  static Future<TreeData> getProjectTree() async {
    Response response = await HttpUtil.getInstance().get(URL_PROJECT_TREE);
    TreeData treeData = TreeData.fromJson(json.decode(response.toString()));
    return treeData;
  }

  ///项目列表
  static Future<ProjectData> getProjectData(int id, int page) async {
    Response response = await HttpUtil.getInstance()
        .get("https://www.wanandroid.com/project/list/$page/json?cid=$id");
    String data = response.data["data"].toString();
    ProjectData bannerData = ProjectData.fromJson(json.decode(data));
    return bannerData;
  }
}
