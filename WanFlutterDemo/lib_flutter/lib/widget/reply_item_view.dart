import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lib_flutter/cfg/wconstans.dart';
import 'package:lib_flutter/entity/reply.dart';
import 'package:lib_flutter/util/time_util.dart';

class ReplyItemView extends StatelessWidget{

  Reply reply;
  ReplyItemView(@required this.reply);
  @override
  Widget build(BuildContext context) {
   
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
                    reply
                        .member
                        .avatar_normal
                        .substring(0)),
                Container(
                    margin: new EdgeInsets.all(5),
                    child: Text(
                      reply.member.username,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    )),
                Text(
                  "${TimeUtil.readTimestamp(reply.last_modified)}",
                  style: TextStyle(
                      color: Colors.grey, fontSize: 11),
                )
              ],
            ),
            Expanded(
              child: Container(
                  margin:
                  new EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(reply.content,
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: REPLY_CONTENT_TEXT_SIZE,
                          color: Colors.black))),
            ),
          ],
        ),
      ),
    );
  }
  
  
  
}