import 'package:flutter/widgets.dart';
import 'package:lib_flutter/entity/tree_item.dart';

class Util {
  static String getChildrenTreeNames(TreeItem treeItemList) {
    String names = "";
    treeItemList.children.forEach((item) {
      if (names.isEmpty) {
        names = item.name;
      } else {
        names = names + "   " + item.name;
      }
    });

    return names;
  }
 static Image getImage(path) {
    return new Image.asset(
      path,
      width: 30.0,
      height: 30.0,
    );
  }
}
