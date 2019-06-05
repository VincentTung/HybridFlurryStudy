import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/entity/vnode.dart';
import 'package:lib_flutter/entity/topic.dart';
import 'package:lib_flutter/ui/allnode_page.dart';
import 'package:lib_flutter/ui/reply_page.dart';
import 'package:lib_flutter/util/time_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lib_flutter/widget/loading_view.dart';
import 'package:lib_flutter/widget/tab_text.dart';

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
  static const List<String> NAMES = [
    "Apple",
    "酷工作",
    "二手交易",
    "Anroid",
    "最热",
    "全部"
  ];
  static const List<int> IDS = [184, 43, 69, 39, 0, 0];
  bool isLoading = true;
  var _scrollController = ScrollController();
  num page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
//        requestData(page + 1);
      }
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
                  children: <Widget>[
                    TabText(NAMES[0], tabIndex == 0, () => {setTabIndex(0)}),
                    TabText(NAMES[1], tabIndex == 1, () => {setTabIndex(1)}),
                    TabText(NAMES[2], tabIndex == 2, () => {setTabIndex(2)}),
                    TabText(NAMES[3], tabIndex == 3, () => {setTabIndex(3)}),
                    TabText(NAMES[4], tabIndex == 4, () => {setTabIndex(4)}),
                    TabText(
                        NAMES[5],
                        tabIndex == 5,
                        () => {
                              Navigator.push(
                                context,
                                new CupertinoPageRoute(
                                    builder: (context) => new AllNodePage(
                                          title: "全部节点",
                                        )),
                              ),
                            }),
                  ],
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
                      return GestureDetector(
                          onTap: () => Navigator.push(
                                context,
                                new CupertinoPageRoute(
                                    builder: (context) =>
                                        new ReplyPage(topic: topicList[index])),
                              ),
                          child: Container(
                            margin: new EdgeInsets.all(5.0),
                            color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.network("http:" +
                                        topicList[index]
                                            .member
                                            .avatar_normal
                                            .substring(0)),
                                    Container(
                                      margin: new EdgeInsets.all(5.0),
                                      child: Text(
                                        topicList[index].member.username,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    margin:
                                        new EdgeInsets.fromLTRB(5, 10, 5, 10),
                                    child: Text(
                                      topicList[index].title,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    )),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "${TimeUtil.readTimestamp(topicList[index].last_modified)}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 1, 10, 1),
                                      decoration: new BoxDecoration(
                                        border: new Border.all(
                                            color: Colors.grey, width: 0.5),
                                        color: Colors.blueGrey,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            new BorderRadius.circular((10)),
                                      ),
                                      child: Text(
                                        topicList[index].replies.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ],
                            ),
                          ));
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
              if (!topicInfo.isEmpty) {
                this.page = page;
              }
            })
          });
    }
  }
}


