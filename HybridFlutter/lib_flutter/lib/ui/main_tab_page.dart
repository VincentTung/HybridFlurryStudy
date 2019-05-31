import 'package:flutter/material.dart';
import 'package:lib_flutter/ui/home_page.dart';
import 'package:lib_flutter/ui/knowledge_page.dart';

///主页
class MainTagPage extends StatefulWidget {
  @override
  _MainPageState createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainTagPage> {
  static const List<String> _tabTitles = ['首页', '知识体系', '公众号', '导航', '项目'];
  static const Color TAB_COLOR_SELECT = Colors.orange;
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
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            appBar: AppBar(
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
            body: SizedBox.expand(
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            )));
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
        getTabImage('images/icon_navigation_not_selected.png'),
        getTabImage('images/icon_navigation_selected.png')
      ],
      [
        getTabImage('images/icon_navigation_not_selected.png'),
        getTabImage('images/icon_navigation_selected.png')
      ]
    ];

    _pages = [
      new HomePage(),
      new KnowLedgePage(),
      new KnowLedgePage(),
      new KnowLedgePage(),
      new KnowLedgePage()
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
