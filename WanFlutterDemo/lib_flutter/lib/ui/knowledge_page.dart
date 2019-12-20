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
  List<TreeItem> _treeItemList ;
  ScrollController _scrollController = ScrollController();

  KnowledgeBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<KnowledgeBloc>(context);
    requestData();
    super.initState();
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
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  _treeItemList = snapshot.data;
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new KnowledgeTabPage(
                                              _treeItemList[index])));
                            },
                            child: Padding(
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //名字、类型

                                    Text(
                                      _treeItemList[index].name,
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
                                                  _treeItemList[index]),
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
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return CustomDivider();
                      },
                      itemCount: _treeItemList.length);
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
