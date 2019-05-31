import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_flutter/entity/article.dart';
import 'package:lib_flutter/entity/project_item.dart';

// ignore: must_be_immutable
class ProjectItemView extends StatelessWidget {
  VoidCallback onItemPressed;
  ProjectItem article;

  ProjectItemView(this.onItemPressed, this.article);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onItemPressed,
        child: Padding(
          child: Row(
            children: <Widget>[
              Image.network(
                article.envelopePic,
                width: 100,height: 100,fit: BoxFit.fitWidth,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      //名字、类型
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            article.author,
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                            textAlign: TextAlign.left,
                          ),
                          Expanded(
                            child: Text(
                              article.superChapterName,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: //文章标题
                            Text(article.title,
                                style:
                                    TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                      Row(
                        children: <Widget>[
                          Text(article.niceDate),
                          Expanded(
                            child: Text(
                              article.fresh ? "新" : "",
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 13),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        ));
  }
}
