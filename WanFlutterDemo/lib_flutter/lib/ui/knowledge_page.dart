import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_flutter/bloc/bloc_provider.dart';
import 'package:lib_flutter/bloc/knowledge_bloc.dart';
import 'package:lib_flutter/cfg/wconstans.dart';
import 'package:lib_flutter/entity/tree_item.dart';
import 'package:lib_flutter/ui/knowlege_tab_page.dart';
import 'package:lib_flutter/util/util.dart';

import 'package:lib_flutter/widget/custom_divider.dart';
import 'package:lib_flutter/widget/knowledge_item_view.dart';

///知识体系
class KnowLedgePage extends StatefulWidget {
  @override
  _KnowLedgePageState createState() {
    return _KnowLedgePageState();
  }
}

class _KnowLedgePageState extends State<KnowLedgePage>
    with AutomaticKeepAliveClientMixin {
  static const MethodChannel testMethodChannel =
      MethodChannel(METHOD_CHANNEL_WEB_VIEW);
  List<TreeItem> _treeItemList = List();

  ScrollController _scrollController = ScrollController();
  KnowledgeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<KnowledgeBloc>(context);
    requestData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          _treeItemList.clear();
          return requestData();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: _bloc.outer,
                initialData: List<TreeItem>(),
                builder: (BuildContext context, AsyncSnapshot<List<TreeItem>> snapshot) {
                  _treeItemList = snapshot.data;
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return KnowledgeItemView(_treeItemList[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return CustomDivider();
                      },
                      itemCount:
                          _treeItemList.isEmpty ? 0 : _treeItemList.length);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future requestData() {
    return _bloc.getData();
  }
}
