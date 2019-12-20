import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lib_flutter/entity/tree_item.dart';
import 'package:lib_flutter/ui/knowlege_tab_page.dart';
import 'package:lib_flutter/util/util.dart';

class KnowledgeItemView extends StatelessWidget{

  TreeItem _treeItem;
  KnowledgeItemView(this._treeItem);
  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new KnowledgeTabPage(
                      _treeItem)));
        },
        child: Padding(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //名字、类型

                Text(
                  _treeItem.name,
                  style: TextStyle(
                      color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.left,
                ),

                Padding(
                  padding:
                  EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: //文章标题
                  Text(
                      Util.getChildrenTreeNames(
                          _treeItem),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          height: 1.2)),
                ),
              ],
            ),
          ),
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        ));
  }


}