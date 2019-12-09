import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/cfg/wconstans.dart';
import 'package:lib_flutter/entity/article.dart';
import 'package:lib_flutter/entity/chapter_item.dart';
import 'package:lib_flutter/entity/project_item.dart';
import 'package:lib_flutter/entity/tree_item.dart';
import 'package:lib_flutter/util/custom_scrollcontroller.dart';
import 'package:lib_flutter/widget/article_item_view.dart';
import 'package:lib_flutter/widget/project_item_view.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

///项目
// ignore: must_be_immutable
class ProjectTabPage extends StatefulWidget {
  ProjectTabPage();

  @override
  _ProjectTabPageState createState() {
    return _ProjectTabPageState();
  }
}

class _ProjectTabPageState extends State<ProjectTabPage>
    with TickerProviderStateMixin {
  static const MethodChannel _methodChannel =
      MethodChannel(METHOD_CHANNEL_WEB_VIEW);
  var _scrollController;
  TabController _tabController;
  List<Widget> _tabWidgets = List();
  List<TreeItem> _chapterIteList = new List();
  Map<int, List<ProjectItem>> _dataMap = new Map();
  Map<int, int> _dataPage = new Map();
  bool _getTabs = false;

  List<Widget> _children;

  @override
  void initState() {
    super.initState();
    ApiHelper.getProjectTree().then((chapterData) {
      chapterData.data.forEach((chapterItem) {
        _tabWidgets.add(Padding(
            padding: EdgeInsets.fromLTRB(2, 10, 2, 10),
            child: Text(chapterItem.name)));
      });
      setState(() {
        _getTabs = true;
        _chapterIteList.addAll(chapterData.data);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_tabController != null) {
      _tabController.dispose();
      _scrollController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: getChildren(),
        ),
      ),
    );
  }

  Future getArticle(int page, int id) {
    return ApiHelper.getProjectData(id, page).then((articleData) {
      setState(() {
        _dataPage[id] = articleData.curPage;
        if (_dataMap[id] == null) {
          _dataMap[id] = articleData.datas;
        } else {
          if (articleData.curPage == 0) {
            _dataMap[id].clear();
          }
          _dataMap[id].addAll(articleData.datas);
        }
      });
    });
  }

  List<Widget> getChildren() {
    if (!_getTabs) {
      return [
        Container(
          color: Colors.yellow,
        )
      ];
    } else {
      if (_scrollController == null) {
        getArticle(0, _chapterIteList[0].id);
        _scrollController = new CustomScrollController(() {
          if (_chapterIteList.length > 0) {
            int index = _tabController.index;
            int id = _chapterIteList[index].id;
            int page = _dataPage[id];
            getArticle(page, id);
          }
        });

        _tabController =
            TabController(length: _chapterIteList.length, vsync: this);

        _tabController.addListener(() {
          int id = _chapterIteList[_tabController.index].id;
          if (_dataPage[id] == null && _dataMap[id] == null) {
            getArticle(0, id);
          }
          switch (_tabController.index) {
          }
        });
      }

      return [
        TabBar(
          controller: _tabController,
          labelStyle: TextStyle(fontWeight: FontWeight.w700),
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Color(0xff1a73e8),
          unselectedLabelColor: Color(0xff5f6368),
          isScrollable: true,
          indicator: MD2Indicator(
              indicatorHeight: 3,
              indicatorColor: Color(0xff1a73e8),
              indicatorSize: MD2IndicatorSize.normal),
          tabs: _tabWidgets,
        ),
        Expanded(
            child: TabBarView(
                controller: _tabController,
                children: _chapterIteList.map((treeItem) {
                  return RefreshIndicator(
                      onRefresh: () {
                        int index = _tabController.index;
                        int id = _chapterIteList[index].id;
                        _dataPage[id] = 0;
                        _dataMap[id].clear();
                        return getArticle(0, id);
                      },
                      child: ListView.separated(
                          controller: _scrollController,
                          itemBuilder: (BuildContext context, int index) {
                            return ProjectItemView(() {
                              _methodChannel.invokeMethod("article_detail",
                                  _dataMap[treeItem.id][index].link);
                            }, _dataMap[treeItem.id][index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(color: Colors.grey, height: 0.5);
                          },
                          itemCount: _dataMap[treeItem.id] == null
                              ? 0
                              : _dataMap[treeItem.id].length));
                }).toList())),
      ];
    }
  }
}
