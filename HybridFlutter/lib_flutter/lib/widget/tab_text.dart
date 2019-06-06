import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabText extends StatefulWidget {
  String name;
  bool isCurrent;
  var onClick;

  TabText(this.name, this.isCurrent, this.onClick);

  @override
  _TabTextState createState() {
    // TODO: implement createState
    return _TabTextState();
  }
}

class _TabTextState extends State<TabText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onClick,
        child: Container(
          height: 26,
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey, width: 0.5),
            color: widget.isCurrent
                ? const Color(0xFF0099ff)
                : const Color(0xf3f3f3ff),
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular((10)),
          ),
          child:Center(
            child:
              Text(
                widget.name,
                style: TextStyle(
                    color: widget.isCurrent ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.bold),
              )
          ),
        ));
  }
}