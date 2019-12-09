import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() {
    return _WebViewPageState();
  }
}


int syncFibonacci(int n){
  return n < 2 ? n : syncFibonacci(n-2) + syncFibonacci(n-1);
}


class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
       return Scaffold(
        appBar: AppBar(
        title: Text("kkkk"),
    ),
    body:Container(child:Text("kkkkk"),));

  }


}


//看到这个main函数没？它作为入口函数，它本身也是在一个isolate内部运行。
void main() {
  //Isolate的概念，利用 彼此隔离的堆内存，运行异步任务。 多个isolate之间可以相互通信。
  ReceivePort receiverPort = new ReceivePort(); // 卧槽，怎么没有代码提示
  //这个时候拿到了一个当前isolate的接收端口

  //创建一个另外的Isolate，老叫英文挺别扭的，就叫你吧
  //创建，第一个参数是 一个Function ，方法，可以传匿名方法，也可以自定义
  Isolate.spawn(entryPoint, receiverPort.sendPort);
  //这样就新创建了一个，并且把main这个的sendPort传给了它，让main可以传消息到 新创建的

  receiverPort.listen((t) {//dart的一个isolate的运行过程，也是通过事件驱动的，通过事件队列的循环，来响应各种变化。
    if (t is SendPort) {
      print("main给B发送消息 ，内容为：收到收到");
      t.send(
          "收到收到!"); //我这里拿到了B的sendPort，也给他发了消息，但是B并没有收到。为啥？因为B并没有注册监听呀。擦？
    } else
      print("main接收到 B  发来的消息~~~~~" + t);
  });

//  sleep(Duration(seconds: 2)); //由于这里是单线程,所以main函数这个，要执行lis中的内容，也必须要等休眠结束
//  print("main睡眠结束"); //

}

//参数：sendPort 是main函数所在的传过来的sendPort，所以，当前这个可以用它来向main传信
void entryPoint(SendPort sendPort) {
  print("B 给main发送消息 ，内容为：我是B，我给main 发消息啦");
  sendPort.send("我是B，我给main 发消息啦"); //  但是我传了，main没收到？是的，main并没有注册监听器

  ReceivePort receiverPort = new ReceivePort();
  sendPort.send(receiverPort.sendPort); //但是我们要实现双向通信，那就必须，把B的sendPort给main

  receiverPort.listen((t) {
    print("B接收到 main 的消息~~~~~" + t);
  });
}
