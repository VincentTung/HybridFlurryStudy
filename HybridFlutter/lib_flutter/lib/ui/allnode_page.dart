import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/entity/vnode.dart';
import 'package:lib_flutter/ui/topiclist_page.dart';
import 'package:lib_flutter/widget/loading_view.dart';

/// 所有节点列表页
class AllNodePage extends StatefulWidget {
  final String title;

  AllNodePage({Key key, this.title}) : super(key: key);

  @override
  _AllNodePageState createState() => _AllNodePageState();
}

class _AllNodePageState extends State<AllNodePage> {
  List<VNode> nodeList = new List();

  @override
  void initState() {
    super.initState();
    ApiHelper.getAllNode().then((allNode) {
      setState(() {
        nodeList.addAll(allNode);
      });
    });
  }

  Widget getBody() {
    if (nodeList.isEmpty) {
      return Center(
        child: LoadingView(nodeList.isEmpty),
      );
    } else {
      return Container(
          child: new GridView.count(
        physics: const AlwaysScrollableScrollPhysics(),
        crossAxisCount: 3,
        children: new List.generate(nodeList.length, (index) {
          return new Center(
            child: Container(
              alignment: Alignment(0, 0.5),
              color: Colors.white,
              child: GestureDetector(
                  onTap: () => Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new TopicListPage(
                                  node: nodeList[index],
                                )),
                      ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Image.network(
                          "http:" + nodeList[index].avatar_normal.substring(0)),
                      Text(nodeList[index].name),
                    ],
                  )),
            ),
          );
        }),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: getBody());
  }
}
