import 'package:flutter/material.dart';
import 'package:banner_view/banner_view.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/entity/article.dart';
import 'package:lib_flutter/entity/banner_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  static const MethodChannel testMethodChannel =
      MethodChannel('com.vincent.wanandroid/article_webview');

  List<Widget> _bannerWidgets = new List();
  List<BannerItem> _bannerData = new List();
  static const double BANNER_HEIGHT = 200;

  List<Article> _articleList = new List();
  bool _getBanner = false;
  int _page = 0;
  var _scrollController = ScrollController();
  bool _onRefesh = false;

  RefreshIndicator _refreshIndicator;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        requestData(_page + 1);
      }
    });
    testMethodChannel.setMethodCallHandler((MethodCall call) {
      if (call.method == 'webview_loadStart') {
        setState(() {});
      } else if (call.method == 'webview_loadEnd') {
        setState(() {});
      }
    });
    ApiHelper.getBanner().then((bannerData) {
      setState(() {
        _bannerData.addAll(bannerData.data);
        _bannerData.forEach((banner) {
          _bannerWidgets.add(GestureDetector(
            child: Image.network(
              banner.imagePath,
              fit: BoxFit.fill,
            ),
            onTap: () {
              testMethodChannel.invokeMethod(
                  "article_detail",banner.url);
            },
          ));
        });

        _getBanner = true;
      });
    });

    requestData(_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _refreshIndicator = RefreshIndicator(
        onRefresh: () {
          _articleList.clear();
          _page = 0;
         return  requestData(_page);
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
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          testMethodChannel.invokeMethod(
                              "article_detail", _articleList[index].link);
                        },
                        child: Padding(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              //名字、类型
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    _articleList[index].author,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    textAlign: TextAlign.left,
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      _articleList[index].superChapterName,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: //文章标题
                                    Text(_articleList[index].title,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(_articleList[index].niceDate),
                                  Offstage(
                                      offstage: _articleList[index].fresh,
                                      child: Text("新")),
                                ],
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(color: Colors.grey, height: 0.5);
                  },
                  itemCount: _articleList.length)
            ],
          ),
        ),
      ),
    );
  }

  Future requestData(int page) {
    return ApiHelper.getArticleData(page).then((data) {
      setState(() {
        _articleList.addAll(data.datas);
        _page = data.curPage;

      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
