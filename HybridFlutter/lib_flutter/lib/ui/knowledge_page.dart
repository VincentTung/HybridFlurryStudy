import 'package:flutter/material.dart';
import 'package:banner_view/banner_view.dart';
class KnowLedgePage extends StatefulWidget {
  @override
  _KnowLedgePageState createState() {
    return _KnowLedgePageState();
  }
}

class _KnowLedgePageState extends State<KnowLedgePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "KnowLedgePage",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}