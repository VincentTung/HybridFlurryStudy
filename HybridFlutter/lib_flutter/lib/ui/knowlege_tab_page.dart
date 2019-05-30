import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/entity/tree_item.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class KnowledgeTabPage extends StatefulWidget {
  @override
  _KnowledgeTabPageState createState() {
    return _KnowledgeTabPageState();
  }
}

class _KnowledgeTabPageState extends State<KnowledgeTabPage> {
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
      body:

           Column(
            children: <Widget>[
//              TabBar(
//                labelStyle: TextStyle(
//                  //up to your taste
//                    fontWeight: FontWeight.w700),
//                indicatorSize: TabBarIndicatorSize.label,
//                //makes it better
//                labelColor: Color(0xff1a73e8),
//                //Google's sweet blue
//                unselectedLabelColor: Color(0xff5f6368),
//                //niceish grey
//                isScrollable: true,
//                //up to your taste
//                indicator: MD2Indicator(
//                  //it begins here
//                    indicatorHeight: 3,
//                    indicatorColor: Color(0xff1a73e8),
//                    indicatorSize: MD2IndicatorSize
//                        .normal //3 different modes tiny-normal-full
//                ),
//                tabs: <Widget>[
//                  Tab(
//                    text: "Home",
//                  ),
//                  Tab(
//                    text: "Personal info",
//                  ),
//                  Tab(
//                    text: "Data & personalization",
//                  ),
//                  Tab(
//                    text: "Security",
//                  )
//                ],
//              ),
              Container(height: 2,color: Colors.blue,)
            ],
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
      names = names + "   " + item.name;
    });

    return names;
  }
}
