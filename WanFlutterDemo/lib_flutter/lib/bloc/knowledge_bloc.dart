import 'dart:async';

import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/bloc/bloc_provider.dart';
import 'package:lib_flutter/entity/tree_item.dart';

class KnowledgeBloc extends BlocBase {

  StreamController<List<TreeItem>> _controller =
  new StreamController<List<TreeItem>>();


  StreamSink<List<TreeItem>> get inner => _controller.sink;
  Stream<List<TreeItem>> get outer => _controller.stream;



  @override
  void dispose() {
    _controller.close();
  }

  @override
  Future getData() {
    return ApiHelper.getTreeData().then((data) {
      inner.add(data.data);
    });
  }

  @override
  void resetData() {

  }
}
