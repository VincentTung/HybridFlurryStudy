import 'package:flutter/material.dart';

class CustomScrollController extends ScrollController {
  var requestData;

  CustomScrollController(this.requestData) {
    addListener(() {
      if (this.position.pixels == this.position.maxScrollExtent) {
        requestData();
      }
    });
  }
}
