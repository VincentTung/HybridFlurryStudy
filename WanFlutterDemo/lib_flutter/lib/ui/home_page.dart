import 'package:banner_view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/bloc/bloc_provider.dart';
import 'package:lib_flutter/bloc/home_page_bloc.dart';
import 'package:lib_flutter/cfg/wconstans.dart';
import 'package:lib_flutter/entity/article.dart';
import 'package:lib_flutter/entity/banner_item.dart';
import 'package:lib_flutter/util/custom_scrollcontroller.dart';
import 'package:lib_flutter/widget/article_item_view.dart';
import 'package:lib_flutter/widget/custom_divider.dart';

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

  static const String METHOD_WEBVIEW = "article_detail";
  static const String METHOD_BANNER_DONE = "banner_done";
  List<Widget> _bannerWidgets = new List();
  List<BannerItem> _bannerData = new List();
  static const double BANNER_HEIGHT = 200;

  List<Article> _articleList = new List();
  bool _getBanner = false;
  int _page = 0;
  var _scrollController;
  HomePageBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HomePageBloc>(context);
    bloc.getArticle();
    _scrollController = CustomScrollController(() {
      bloc.getArticle();
    });
//    _methodChannel.setMethodCallHandler((MethodCall call) {
//      if (call.method == 'webview_loadStart') {
//        setState(() {});
//      } else if (call.method == 'webview_loadEnd') {
//        setState(() {});
//      }
//    });
//    ApiHelper.getBanner().then((bannerData) {
//      setState(() {
//        _bannerData.addAll(bannerData.data);
//        _bannerData.forEach((banner) {
//          _bannerWidgets.add(GestureDetector(
//            child: Image.network(
//              banner.imagePath,
//              fit: BoxFit.fill,
//            ),
//            onTap: () {
//              _methodChannel.invokeMethod(METHOD_WEBVIEW, banner.url);
//            },
//          ));
//        });
//
//        _getBanner = true;
//
//        try {
//          _methodChannel.invokeMethod(METHOD_BANNER_DONE);
//        } on Exception catch (e) {}
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          _articleList.clear();
          _page = 0;
          bloc.resetArticlePage();
          bloc.getArticle();
          return;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              Offstage(
                  offstage: !_getBanner,
                  child: Container(
                    child: _getBanner
                        ? BannerView(
                            _bannerWidgets,
                            log: false,
                          )
                        : new Container(),
                    height: BANNER_HEIGHT,
                  )),
              StreamBuilder<List<Article>>(
                  stream: bloc.outCounter,
                  initialData: List<Article>(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Article>> snapshot) {

                    return  ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ArticleItemView(() {
                            _methodChannel.invokeMethod(
                                METHOD_WEBVIEW, snapshot.data[index].link);
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

//  Future requestData(int page) {
//    return ApiHelper.getArticleData(page).then((data) {
//      setState(() {
//        _articleList.addAll(data.datas);
//        _page = data.curPage;
//      });
//    });
//  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
