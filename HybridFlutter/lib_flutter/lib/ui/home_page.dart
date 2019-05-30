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

  @override
  void initState() {
    super.initState();
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
              //打开url
              Fluttertoast.showToast(msg: banner.url);
            },
          ));
        });

        _getBanner = true;
      });
    });

    ApiHelper.getArticleData(_page).then((data) {
      setState(() {
        _articleList.addAll(data.datas);
        _page = data.curPage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Offstage(
                offstage: !_getBanner,
                child: Container(
                  child:
                      _getBanner ? BannerView(_bannerWidgets) : new Container(),
                  height: BANNER_HEIGHT,
                )),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        testMethodChannel.invokeMethod("article_detail",_articleList[index].link);
                      },
                      child: Padding(
                        child: Column(
                          children: <Widget>[
                            //名字、类型
                            Row(
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
                                    offstage: !_articleList[index].fresh,
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
    );
  }
}
