import 'package:flutter/material.dart';
import 'package:lib_flutter/block/block_provider.dart';
import 'package:lib_flutter/block/countet_page.dart';
import 'package:lib_flutter/block/increment_bloc.dart';
import 'package:lib_flutter/ui/main_tab_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Streams Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<IncrementBloc>(
        bloc: IncrementBloc(),
        child: CounterPage(),
      ),
    );
  }

  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MainTagPage(),
//
//    );
//  }
}

