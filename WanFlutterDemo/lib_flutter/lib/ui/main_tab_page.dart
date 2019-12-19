import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lib_flutter/bloc/bloc_provider.dart';
import 'package:lib_flutter/bloc/home_page_bloc.dart';
import 'package:lib_flutter/ui/home_page.dart';
import 'package:lib_flutter/ui/knowledge_page.dart';
import 'package:lib_flutter/ui/project_tab_page.dart';
import 'package:lib_flutter/ui/topiclist_page.dart';
import 'package:lib_flutter/ui/topiclist_page_tab.dart';
import 'package:lib_flutter/ui/wx_article_tab_page.dart';

///主页
class MainTabPage extends StatefulWidget {
  @override
  _MainPageState createState() {
    return _MainPageState();
  }

  void test() {}
}

class _MainPageState extends State<MainTabPage> {
  GlobalKey<_MainPageState> myWidgetStateKey = new GlobalKey<_MainPageState>();
  static const List<String> _tabTitles = ['首页', '知识体系', '公众号', '项目', 'V站'];
  static const Color TAB_COLOR_SELECT = Colors.blue;
  static const Color TAB_COLOR_NORMAL = Colors.grey;
  List<List> tabImages;
  List<Widget> _pages;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        key: myWidgetStateKey,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(_tabTitles[_currentIndex]),
            ),
            bottomNavigationBar: new BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  new BottomNavigationBarItem(
                      icon: getTabIcon(0), title: getTabTitle(0)),
                  new BottomNavigationBarItem(
                      icon: getTabIcon(1), title: getTabTitle(1)),
                  new BottomNavigationBarItem(
                      icon: getTabIcon(2), title: getTabTitle(2)),
                  new BottomNavigationBarItem(
                      icon: getTabIcon(3), title: getTabTitle(3)),
                  new BottomNavigationBarItem(
                      icon: getTabIcon(4), title: getTabTitle(4)),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                }),
            body: BlocProvider(
                child: SizedBox.expand(
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            ))));
  }

  void initData() {
    tabImages = [
      [
        getTabImage('images/icon_home_pager_not_selected.png'),
        getTabImage('images/icon_home_pager_selected.png')
      ],
      [
        getTabImage('images/icon_knowledge_hierarchy_not_selected.png'),
        getTabImage('images/icon_knowledge_hierarchy_selected.png')
      ],
      [
        getTabImage('images/icon_me_not_selected.png'),
        getTabImage('images/icon_me_selected.png')
      ],
      [
        getTabImage('images/icon_project_not_selected.png'),
        getTabImage('images/icon_project_selected.png')
      ],
      [
        getTabImage('images/v2_not_selected.png'),
        getTabImage('images/v2_selected.png')
      ]
    ];

    _pages = [
      BlocProvider<HomePageBloc>(
        bloc: HomePageBloc(),
        child: new HomePage(),
      ),
      new KnowLedgePage(),
      new WXArticleTabPage(),
      new ProjectTabPage(),
      new TopicListPageTab(),
    ];
  }

  Image getTabImage(path) {
    return new Image.asset(
      path,
      width: 30.0,
      height: 30.0,
    );
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _currentIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  Padding getTabTitle(int curIndex) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: new Text(_tabTitles[curIndex],
            style: new TextStyle(
                color: curIndex == _currentIndex
                    ? TAB_COLOR_SELECT
                    : TAB_COLOR_NORMAL)));
  }
}
