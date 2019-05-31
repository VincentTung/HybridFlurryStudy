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

class _KnowledgeTabPageState extends State<KnowledgeTabPage>
    with SingleTickerProviderStateMixin {
  List<TreeItem> _treeItemList = new List();
  static const MethodChannel testMethodChannel =
  MethodChannel('com.vincent.wanandroid/article_webview');
  var _scrollController = ScrollController();

  TabController _tabController;
  List<Widget> _tabWidgets = List();

  TabBar _tabBar;

  @override
  void initState() {
    _tabController = TabController(length: _tabWidgets.length, vsync: this);
    _tabController.addListener(() {
      switch (_tabController.index) {
      }
    });
    super.initState();

    requestData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _tabBar = TabBar(
              controller: _tabController,
              labelStyle: TextStyle(
                //up to your taste
                  fontWeight: FontWeight.w700),
              indicatorSize: TabBarIndicatorSize.label,
              //makes it better
              labelColor: Color(0xff1a73e8),
              //Google's sweet blue
              unselectedLabelColor: Color(0xff5f6368),
              //niceish grey
              isScrollable: true,
              //up to your taste
              indicator: MD2Indicator(
                //it begins here
                  indicatorHeight: 3,
                  indicatorColor: Color(0xff1a73e8),
                  indicatorSize: MD2IndicatorSize
                      .normal //3 different modes tiny-normal-full
              ),
              tabs:
              _tabWidgets
              ,
            ),

          ],
        ),
      ),
    );
  }

  Future requestData() {
    return ApiHelper.getTreeData().then((data) {
      setState(() {
        _treeItemList.addAll(data.data);
        _tabController  = TabController(length: _tabWidgets.length, vsync: this);
        getTabWidget();

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

    void  getTabWidget() {

    _treeItemList.forEach((treeItem) {
      _tabWidgets.add(Text(treeItem.name));
    });
  }

}
