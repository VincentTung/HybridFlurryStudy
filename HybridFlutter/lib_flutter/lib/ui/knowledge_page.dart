import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/entity/tree_item.dart';

class KnowLedgePage extends StatefulWidget {
  @override
  _KnowLedgePageState createState() {
    return _KnowLedgePageState();
  }
}

class _KnowLedgePageState extends State<KnowLedgePage> {

  List<TreeItem> _treeItemList = new List();
  static const MethodChannel testMethodChannel =
  MethodChannel('com.vincent.wanandroid/article_webview');
  var _scrollController = ScrollController();

  @override
  void initState() {
    requestData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          _treeItemList.clear();

          return requestData();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[

              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {

                        },
                        child: Padding(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              //名字、类型

                              Text(
                                _treeItemList[index].name,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12),
                                textAlign: TextAlign.left,
                              ),


                              Padding(
                                padding: EdgeInsets.all(10),
                                child: //文章标题
                                Text(_treeItemList[index].children[0].name,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14)),
                              ),

                            ],
                          ),
                          padding: EdgeInsets.all(10),
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(color: Colors.grey, height: 0.5);
                  },
                  itemCount: _treeItemList.length)
            ],
          ),
        ),
      ),
    );
  }

  Future requestData() {
    return ApiHelper.getTreeData().then((data) {
      setState(() {
        _treeItemList.addAll(data.data);
      });
    });
  }
}
