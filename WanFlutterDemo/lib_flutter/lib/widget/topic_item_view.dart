import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lib_flutter/entity/topic.dart';
import 'package:lib_flutter/ui/reply_page.dart';
import 'package:lib_flutter/util/time_util.dart';

class TopicItemView extends StatelessWidget {
  
  Topic topic;
  TopicItemView(@required this.topic);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              new CupertinoPageRoute(
                  builder: (context) => new ReplyPage(topic:topic)),
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
                      topic.member.avatar_normal.substring(0)),
                  Container(
                    margin: new EdgeInsets.all(5.0),
                    child: Text(
                      topic.member.username,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Container(
                  margin: new EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Text(
                    topic.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )),
              Row(
                children: <Widget>[
                  Text(
                    "${TimeUtil.readTimestamp(topic.last_modified)}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                    decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.grey, width: 0.5),
                      color: Colors.blueGrey,
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular((10)),
                    ),
                    child: Text(
                      topic.replies.toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ],
          ),
        ));
  }
}
