import 'package:flutter/material.dart';
import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/entity/reply.dart';
import 'package:lib_flutter/entity/topic.dart';
import 'package:lib_flutter/util/time_util.dart';
import 'package:lib_flutter/widget/loading_view.dart';

///主题详细页
class ReplyPage extends StatefulWidget {
  final Topic topic;

  ReplyPage({Key key, @required this.topic}) : super(key: key);

  @override
  _ReplyPageState createState() {
    return _ReplyPageState();
  }
}

class _ReplyPageState extends State<ReplyPage> {
  List<Reply> replyList = new List();
  num topicId;
  bool isLoading = true;

  static const double CONTENT_TEXT_SIZE = 14;
  static const double DIVIDER_HEIGHT = 0.5;

  @override
  void initState() {
    super.initState();
    topicId = widget.topic.id;
    ApiHelper.getReply(topicId).then((replies) => {
          setState(() {
            replyList.addAll(replies);
            isLoading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body:
            Stack(alignment: AlignmentDirectional.topCenter, children: <Widget>[
          Container(
            margin: new EdgeInsets.all(5.0),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.topic.title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                        Container(
                            alignment: AlignmentDirectional.bottomEnd,
                            margin: EdgeInsets.all(6),
                            child: Image.network(
                              "http:" +
                                  widget.topic.member.avatar_normal
                                      .substring(0),
                              alignment: Alignment.centerRight,
                            )),
                        Text(
                          "By ${widget.topic.member.username} at ${TimeUtil.readTimestamp(widget.topic.created)}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          height: DIVIDER_HEIGHT,
                          color: Colors.grey,
                        )
                      ]),
                  Text(widget.topic.content,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: CONTENT_TEXT_SIZE, color: Colors.black)),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    height: DIVIDER_HEIGHT,
                    color: Colors.grey,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Container(
                            height: 100,
                            margin: new EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.network("http:" +
                                        replyList[index]
                                            .member
                                            .avatar_normal
                                            .substring(0)),
                                    Container(
                                        margin: new EdgeInsets.all(5),
                                        child: Text(
                                          replyList[index].member.username,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                    Text(
                                      "${TimeUtil.readTimestamp(replyList[index].last_modified)}",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 11),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                      margin:
                                          new EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: Text(replyList[index].content,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontSize: CONTENT_TEXT_SIZE,
                                              color: Colors.black))),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          height: DIVIDER_HEIGHT,
                          color: Colors.grey,
                        );
                      },
                      itemCount: replyList.length)
                ],
              ),
            ),
          ),
          LoadingView(isLoading),
        ]));
  }
}
