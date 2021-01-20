import 'dart:async';

import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/bloc/bloc_provider.dart';
import 'package:lib_flutter/entity/article.dart';
import 'package:lib_flutter/entity/banner_item.dart';

class BannerBloc extends BlocBase {
  StreamController<List<BannerItem>> _controller =
      new StreamController<List<BannerItem>>();

  StreamSink<List<BannerItem>> get inner => _controller.sink;

  Stream<List<BannerItem>> get outer => _controller.stream;

  @override
  void dispose() {
    _controller.close();
  }

  @override
  Future getData() async{
    return ApiHelper.getBanner().then((bannerData) {
      inner.add(bannerData.data);
    });
  }

  @override
  void resetData() {
  }
}
