import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/entity/tree_item.dart';
import 'package:lib_flutter/ui/knowlege_tab_page.dart';

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
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new KnowledgeTabPage())
                          );
                        },
                        child: Padding(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              //名字、类型

                              Text(
                                _treeItemList[index].name,
                                style:
                                    TextStyle(color: Colors.black, fontSize: 16),
                                textAlign: TextAlign.left,
                              ),

                              Padding(
                                padding: EdgeInsets.all(10),
                                child: //文章标题
                                    Text(
                                        getChildrenTreeNames(
                                            _treeItemList[index]),
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14,height: 1.2)),
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

  String getChildrenTreeNames(TreeItem treeItemList) {
    String names = "";
    treeItemList.children.forEach((item) {
      names = names+ "   "+item.name;
    });

    return names;
  }
}
