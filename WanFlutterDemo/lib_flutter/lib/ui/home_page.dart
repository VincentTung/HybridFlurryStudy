import 'package:banner_view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/bloc/bloc_provider.dart';
import 'package:lib_flutter/bloc/banner_bloc.dart';
import 'package:lib_flutter/bloc/article_bloc.dart';
import 'package:lib_flutter/cfg/wconstans.dart';
import 'package:lib_flutter/entity/article.dart';
import 'package:lib_flutter/entity/banner_item.dart';
import 'package:lib_flutter/util/custom_scrollcontroller.dart';
import 'package:lib_flutter/widget/article_item_view.dart';
import 'package:lib_flutter/widget/custom_divider.dart';
import 'package:permission_handler/permission_handler.dart';

///首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  static const MethodChannel _methodChannel =
      MethodChannel(METHOD_CHANNEL_WEB_VIEW);
  static const double BANNER_HEIGHT = 200;
  static const String METHOD_WEB_VIEW = "article_detail";
  static const String METHOD_BANNER_DONE = "banner_done";

  List<Widget> _bannerWidgets = new List();
  var _scrollController;

  ArticleBloc _articleBloc;
  BannerBloc _bannerBloc;

  @override
  void initState() {
    super.initState();
    _articleBloc = BlocProvider.of<ArticleBloc>(context);
    _bannerBloc = BlocProvider.of<BannerBloc>(context);
    _scrollController = CustomScrollController(() {
      _articleBloc.getData();
    });
    // ignore: missing_return
    _methodChannel.setMethodCallHandler((MethodCall call) {
      if (call.method == 'webview_loadStart') {
        setState(() {});
      } else if (call.method == 'webview_loadEnd') {
        setState(() {});
      }
    });

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return getData();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              Container(
                child: StreamBuilder<List<BannerItem>>(
                  stream: _bannerBloc.outer,
                  initialData: List<BannerItem>(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<BannerItem>> snapshot) {
                    try {
                      if (snapshot.data.isNotEmpty) {
                        _methodChannel.invokeMethod(METHOD_BANNER_DONE);
                      }
                    } on Exception catch (e) {
                      print(e.toString());
                    }
                    _bannerWidgets.clear();
                    snapshot.data.forEach((banner) {
                      _bannerWidgets.add(GestureDetector(
                        child: Image.network(
                          banner.imagePath,
                          fit: BoxFit.fill,
                        ),
                        onTap: () {
                          _methodChannel.invokeMethod(
                              METHOD_WEB_VIEW, banner.url);
                        },
                      ));
                    });
                    return _bannerWidgets.isNotEmpty
                        ? BannerView(
                            _bannerWidgets,
                            log: false,
                          )
                        : Container();
                  },
                ),
                height: BANNER_HEIGHT,
              ),
              StreamBuilder<List<Article>>(
                  stream: _articleBloc.outer,
                  initialData: List<Article>(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Article>> snapshot) {
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ArticleItemView(() {
                            _methodChannel.invokeMethod(
                                METHOD_WEB_VIEW, snapshot.data[index].link);
                          }, snapshot.data[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return CustomDivider();
                        },
                        itemCount: snapshot.data.length);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future getData() {
    _bannerBloc.getData();
    _articleBloc.resetData();
    return _articleBloc.getData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
