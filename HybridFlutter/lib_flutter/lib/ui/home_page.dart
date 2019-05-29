import 'package:flutter/material.dart';
import 'package:banner_view/banner_view.dart';
import 'package:lib_flutter/api/api.dart';
import 'package:lib_flutter/entity/banner_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<Widget> _bannerWidgets = new List();
  List<BannerItem> _bannerData = new List();

  @override
  void initState() {
    super.initState();
    ApiHelper.getBanner().then((bannerData) {
      setState(() {
        _bannerData.addAll(bannerData.data);
        _bannerData.forEach(
                (banner) {
              _bannerWidgets.add(Image.network(banner.url));
            });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[Container(child: BannerView(_bannerWidgets),height: 200,)],
          ),
        ),
      ),
    );
  }
}
