import 'dart:async';

import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/bloc/bloc_provider.dart';
import 'package:lib_flutter/entity/article.dart';

class ArticleBloc extends BlocBase {
  int _page = 0;
  List<Article> _articleList = new List();
  StreamController<List<Article>> _controller =
      new StreamController<List<Article>>();

  StreamSink get inner => _controller.sink;

  Stream<List<Article>> get outer => _controller.stream;

  @override
  void dispose() {
    _controller.close();
  }

  Future getData() {
    return ApiHelper.getArticleData(_page + 1).then((data) {
      _articleList.addAll(data.datas);
      _page = data.curPage;
      inner.add(_articleList);
    });
  }

  void resetData() {
    _page = 0;
    _articleList.clear();
  }
}
