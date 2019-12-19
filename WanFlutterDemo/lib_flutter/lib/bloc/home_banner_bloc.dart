import 'dart:async';

import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/bloc/bloc_provider.dart';
import 'package:lib_flutter/entity/article.dart';
import 'package:lib_flutter/entity/banner_item.dart';

class BannerBloc extends BlocBase {
  int _page = 0;
  List<BannerItem> _bannerList = new List();
  StreamController _counterController = new StreamController();

  StreamSink<List<BannerItem>> get _inAdd => _counterController.sink;

  Stream<List<BannerItem>> get outCounter => _counterController.stream;

  @override
  void dispose() {}

  void getBanners() {
    ApiHelper
        .getBanner()
        .then((bannerData) {
      _inAdd.add(bannerData.data);
    });
  }


  void resetArticlePage() {
    _page = 0;
    _bannerList.clear();
  }
}
