import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_flutter/entity/article.dart';

// ignore: must_be_immutable
class ArticleItemView extends StatelessWidget {
  VoidCallback onItemPressed;
  Article article;

  static const List<String> IMAGES = [
    "images/cake.png"
        "images/ham.png",
    "images/wine.png",
    "images/apple.png"
  ];

  ArticleItemView(this.onItemPressed, this.article);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onItemPressed,
        child: Padding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //名字、类型
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.asset(IMAGES[1],width:20,height:20,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4,0,0,0),
                    child: Text(
                      article.author,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                      textAlign: TextAlign.left,
                    ),
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
                        style: TextStyle(color: Colors.black, fontSize: 15)),
              ),
              Row(
                children: <Widget>[
                  Image.asset("images/date.png",width:20,height:20,),
                 Padding(child: Text(article.niceDate),padding: EdgeInsets.fromLTRB(8, 0, 0, 0)),
                  Expanded(
                    child: Text(
                      article.fresh ? "新" : "",
                      style: TextStyle(color: Colors.orange, fontSize: 13),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        ));
  }
}
