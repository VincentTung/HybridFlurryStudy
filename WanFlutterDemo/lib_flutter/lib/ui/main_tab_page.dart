import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lib_flutter/bloc/bloc_provider.dart';
import 'package:lib_flutter/bloc/banner_bloc.dart';
import 'package:lib_flutter/bloc/article_bloc.dart';
import 'package:lib_flutter/bloc/knowledge_bloc.dart';
import 'package:lib_flutter/cfg/wconstans.dart';
import 'package:lib_flutter/ui/home_page.dart';
import 'package:lib_flutter/ui/knowledge_page.dart';
import 'package:lib_flutter/ui/project_tab_page.dart';

import 'package:lib_flutter/ui/topiclist_page_tab.dart';
import 'package:lib_flutter/ui/wx_article_tab_page.dart';
import 'package:lib_flutter/util/util.dart';

///主页
class MainTabPage extends StatefulWidget {
  @override
  _MainPageState createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainTabPage> {
  GlobalKey<_MainPageState> myWidgetStateKey = new GlobalKey<_MainPageState>();
  List<List> _tabImages = new List();
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
              title: Text(TAB_TITLES[_currentIndex]),
            ),
            bottomNavigationBar: new BottomNavigationBar(
                items: getNavigationItem(),
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                }),
            body: BlocProvider(
                bloc: BannerBloc(),
                child: SizedBox.expand(
                  child: IndexedStack(
                    index: _currentIndex,
                    children: _pages,
                  ),
                ))));
  }

  List<BottomNavigationBarItem> getNavigationItem() {
    List<BottomNavigationBarItem> _btmViews = new List();
    int index = 0;
    _pages.forEach((Widget widget) {
      _btmViews.add(new BottomNavigationBarItem(
          icon: _tabImages[index][0],
          activeIcon: _tabImages[index][1],
          title: getTabTitle(index)));
      index++;
    });
    return _btmViews;
  }

  void initData() {
    _pages = [
      BlocProvider<ArticleBloc>(
        bloc: ArticleBloc(),
        child: new HomePage(),
      ),
      BlocProvider<KnowledgeBloc>(
        bloc: KnowledgeBloc(),
        child: new KnowLedgePage(),
      ),
      new WXArticleTabPage(),
      new ProjectTabPage(),
      new TopicListPageTab(),
    ];

    int index = 0;
    _pages.forEach((Widget widget) {
      _tabImages.add([
        getTabImage(TAB_IMG_NORMAL[index]),
        getTabImage(TAB_IMG_SELECTED[index])
      ]);
      index++;
    });
  }

  Image getTabImage(String name) {
    return Util.getImage("images/" + name);
  }

  Padding getTabTitle(int curIndex) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: new Text(TAB_TITLES[curIndex],
            style: new TextStyle(
                color: curIndex == _currentIndex
                    ? TAB_COLOR_SELECT
                    : TAB_COLOR_NORMAL)));
  }
}
