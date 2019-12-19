//import 'dart:async';
//
//import 'package:lib_flutter/api/api.dart';
//import 'package:lib_flutter/bloc/bloc_provider.dart';
//import 'package:lib_flutter/entity/article.dart';
//import 'package:lib_flutter/entity/banner_item.dart';
//
//class HomePageBloc extends BlocBase {
//  int _page = 0;
//  List<Article> _articleList = new List();
//  StreamController _counterController = new StreamController();
//
//  StreamSink get _inAdd => _counterController.sink;
//
//  Stream<List<BannerItem>> get outCounter => _counterController.stream;
//
//  @override
//  void dispose() {}
//
//  void getArticle() {
//    ApiHelper.getArticleData(_page + 1).then((data) {
//      _articleList.addAll(data.datas);
//      _page = data.curPage;
//      _inAdd.add(_articleList);
//    });
//  }
//
//  void getBanners() {}
//
//  void resetArticlePage() {
//    _page = 0;
//    _articleList.clear();
//  }
//}
