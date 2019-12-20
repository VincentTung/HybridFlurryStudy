import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/cfg/wconstans.dart';
import 'package:lib_flutter/entity/topic.dart';
import 'package:lib_flutter/widget/loading_view.dart';
import 'package:lib_flutter/widget/tab_text.dart';
import 'package:lib_flutter/widget/topic_item_view.dart';

///某个节点下的主题列表页
class TopicListPageTab extends StatefulWidget {
  TopicListPageTab({Key key}) : super(key: key);

  @override
  _TopicListPageTabState createState() => _TopicListPageTabState();
}

class _TopicListPageTabState extends State<TopicListPageTab> {
  List<Topic> topicList = new List();
  int tabIndex = 0;
  num nodeId;
  static const List<int> IDS = [184, 43, 69, 39, 0];
  bool isLoading = true;
  var _scrollController = ScrollController();
  num page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
    requestData(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Container(
      color: Colors.white,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: getTabText(),
                ),
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return TopicItemView(topicList[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(height: 0.5, color: Colors.grey);
                    },
                    itemCount: topicList.length),
              ],
            ),
            LoadingView(isLoading),
          ],
        ),
      ),
    )));
  }

  void setTabIndex(int i) {
    setState(() {
      tabIndex = i;
      page = 0;
      topicList.clear();
      requestData(page);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void requestData(num page) {
    isLoading = true;
    if (tabIndex == 4) {
      ApiHelper.getHotTopics().then((topicInfo) => {
            setState(() {
              topicList.addAll(topicInfo);
              isLoading = false;
            })
          });
    } else if (tabIndex == 5) {
    } else {
      nodeId = IDS[tabIndex];
      ApiHelper.getTopicsUnderNode(nodeId, page).then((topicInfo) => {
            setState(() {
              topicList.addAll(topicInfo);
              isLoading = false;
              if (topicInfo.isNotEmpty) {
                this.page = page;
              }
            })
          });
    }
  }

  List<TabText> getTabText() {
    List<TabText> list = new List();
    int index = 0;
    V2EX_TAB_TITLES.forEach((String title) {
      int value = index.toInt();
      list.add(TabText(title, tabIndex == index, () => setTabIndex(value)));
      index++;
    });
    return list;
  }
}
