import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:lib_flutter/cfg/url.dart';
import 'package:lib_flutter/entity/article_data.dart';
import 'package:lib_flutter/entity/article_result.dart';
import 'package:lib_flutter/entity/banner_data.dart';
import 'package:lib_flutter/entity/chapter_data.dart';
import 'package:lib_flutter/entity/community_info.dart';
import 'package:lib_flutter/entity/community_promotion.dart';
import 'package:lib_flutter/entity/project_data.dart';
import 'package:lib_flutter/entity/project_result.dart';
import 'package:lib_flutter/entity/reply.dart';
import 'package:lib_flutter/entity/topic.dart';
import 'package:lib_flutter/entity/tree_data.dart';
import 'package:lib_flutter/entity/user.dart';
import 'package:lib_flutter/entity/vnode.dart';
import 'package:lib_flutter/net/httputil.dart';

class ApiHelper {
  ///wanandroid部分
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
        .get("$WAN_BASE_URL/article/list/$page/json");
    ArticleResult bannerData =
        ArticleResult.fromJson(json.decode(response.toString()));
    return bannerData.data;
  }

  ///知识体系
  static Future<TreeData> getTreeData() async {
    Response response = await HttpUtil.getInstance().get(URL_TREE);
    TreeData treeData = TreeData.fromJson(json.decode(response.toString()));
    return treeData;
  }

  ///获取首页文章
  static Future<ArticleData> getArticleDataUnderTree(int page, int id) async {
    Response response = await HttpUtil.getInstance().get(
      "$WAN_BASE_URL/article/list/$page/json?cid=$id",
    );
    ArticleResult bannerData =
        ArticleResult.fromJson(json.decode(response.toString()));
    return bannerData.data;
  }

  ///获取公众号tab
  static Future<ChapterData> getChapterData() async {
    Response response = await HttpUtil.getInstance().get(URL_CHAPTER);
    ChapterData bannerData =
        ChapterData.fromJson(json.decode(response.toString()));
    return bannerData;
  }

  ///公众号文章
  static Future<ArticleData> getWXArticleData(int id, int page) async {
    Response response = await HttpUtil.getInstance()
        .get("$WAN_BASE_URL/wxarticle/list/$id/$page/json");
    ArticleResult bannerData =
        ArticleResult.fromJson(json.decode(response.toString()));
    return bannerData.data;
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
        .get("$WAN_BASE_URL/project/list/$page/json?cid=$id");
    ProjectResult projectResult =
        ProjectResult.fromJson(json.decode(response.toString()));
    return projectResult.data;
  }

  ///V2EX部分
  /// 某个用户的信息
  static  Future<User> getUserInfo(int userId) async {
    Map<String, dynamic> params = new Map();
    params["id"] = userId;
    Response response = await HttpUtil.getInstance()
        .get(V_BASE_URL + "/api/members/show.json", data: params);
    User aUser = User.fromJson(json.decode(response.toString()));
    return aUser;
  }

  /// 所有节点
  static  Future<List<VNode>> getAllNode() async {
    Response response =
    await HttpUtil.getInstance().get(V_BASE_URL + "/api/nodes/all.json");
    List<dynamic> da = response.data;
    List<VNode> nodeList = da.map((item) => VNode.fromJson(item)).toList();
    return nodeList;
  }

  ///获取某个节点信息
  static  Future<VNode> getNodeInfo(int nodeId) async {
    Map<String, dynamic> params = new Map();
    params["id"] = nodeId;
    Response response = await HttpUtil.getInstance()
        .get(V_BASE_URL + "/api/nodes/show.json", data: params);

    VNode node = VNode.fromJson(json.decode(response.toString()));
    return node;
  }

  ///主题信息
  static  Future<Topic> getTopicInfo(int topicId) async {
    Map<String, dynamic> params = new Map();
    params["id"] = topicId;
    Response response = await HttpUtil.getInstance()
        .get(V_BASE_URL + "/api/topics/show.json", data: params);
    List<dynamic> da = response.data;
    Topic node = Topic.fromJson(da[0]);
    return node;
  }

  ///最热主题
  static  Future<List<Topic>> getHotTopics() async {
    Response response =
    await HttpUtil.getInstance().get(V_BASE_URL + "/api/topics/hot.json");
    List<dynamic> da = response.data;
    List<Topic> nodeList = da.map((item) => Topic.fromJson(item)).toList();
    return nodeList;
  }

  ///获取回复
  static  Future<List<Reply>> getReply(num topicId) async {
    Map<String, dynamic> params = new Map();
    params["topic_id"] = topicId;
    Response response = await HttpUtil.getInstance()
        .get(V_BASE_URL + "/api/replies/show.json", data: params);
    List<dynamic> da = response.data;
    List<Reply> replyList = da.map((item) => Reply.fromJson(item)).toList();
    return replyList;
  }

  ///获取某个节点下的主题列表
  static Future<List<Topic>> getTopicsUnderNode(num nodeId,num page) async {
    Map<String, dynamic> params = new Map();
    params["node_id"] = nodeId;
    params["page"] = page;
    Response response = await HttpUtil.getInstance()
        .get(V_BASE_URL + "/api/topics/show.json", data: params);
    List<dynamic> da = response.data;
    List<Topic> replyList = da.map((item) => Topic.fromJson(item)).toList();
    return replyList;
  }

  ///获取用户的主题列表
  static Future<List<Topic>> getTopicsByUserName(String username) async {
    Map<String, dynamic> params = new Map();
    params["username"] = username;
    Response response = await HttpUtil.getInstance()
        .get(V_BASE_URL + "/api/topics/show.json", data: params);
    List<dynamic> da = response.data;
    List<Topic> replyList = da.map((item) => Topic.fromJson(item)).toList();
    return replyList;
  }

  ///获取用户的主题列表
  static  Future<List<Topic>> getTopicsByUserId(num userId) async {
    Map<String, dynamic> params = new Map();
    params["id"] = userId;
    Response response = await HttpUtil.getInstance()
        .get(V_BASE_URL + "/api/topics/show.json", data: params);
    List<dynamic> da = response.data;
    List<Topic> replyList = da.map((item) => Topic.fromJson(item)).toList();
    return replyList;
  }

  ///社区信息
  static Future<CommunityInfo> getCommunityInfo() async {
    Response response =
    await HttpUtil.getInstance().get(V_BASE_URL + "/api/site/info.json");
    CommunityInfo cinfo =
    CommunityInfo.fromJson(json.decode(response.toString()));
    return cinfo;
  }

  ///社区动态
  static Future<CommunityPromotion> getCommunityPromotion() async {
    Response response =
    await HttpUtil.getInstance().get(V_BASE_URL + "/api/site/stats.json");
    CommunityPromotion cpro =
    CommunityPromotion.fromJson(json.decode(response.toString()));
    return cpro;
  }
}
