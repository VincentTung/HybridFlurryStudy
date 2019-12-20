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
}
