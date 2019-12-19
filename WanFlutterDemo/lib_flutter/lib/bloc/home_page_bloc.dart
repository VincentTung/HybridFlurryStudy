import 'dart:async';

import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/bloc/bloc_provider.dart';
import 'package:lib_flutter/entity/article.dart';

class HomePageBloc extends BlocBase {
  int _page = 0;
  List<Article> _articleList = new List();
  StreamController<List<Article>> _counterController = new StreamController<List<Article>>();

  StreamSink get _inAdd => _counterController.sink;

  Stream<List<Article>> get outCounter => _counterController.stream;

  @override
  void dispose() {
    _inAdd.close();
  }

  void getArticle() {
    ApiHelper.getArticleData(_page + 1).then((data) {
      _articleList.addAll(data.datas);
      _page = data.curPage;
      _inAdd.add(_articleList);
    });
  }

  void getBanners() {}

  void resetArticlePage() {
    _page = 0;
    _articleList.clear();
  }
}
