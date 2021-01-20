import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lib_flutter/cfg/wconstans.dart';

// ignore: must_be_immutable
class LoadingView extends StatefulWidget {

  bool _isLoading;

  LoadingView(bool isLoading){
    this._isLoading = isLoading;
  }

  @override
  _LoadingView createState() {
    return _LoadingView();
  }
}

class _LoadingView extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !widget._isLoading,
      child: SpinKitCircle(
        color: BASE_COLOR,
      ),
    );
  }
}
