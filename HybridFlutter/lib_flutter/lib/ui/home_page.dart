import 'package:flutter/material.dart';
import 'package:banner_view/banner_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<Widget> _banners = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[BannerView(_banners)],
          ),
        ),
      ),
    );
  }
}
