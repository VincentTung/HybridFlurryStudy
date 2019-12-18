import 'dart:async';

import 'dart:collection';

void main() {
  //
  // 初始化“单订阅”流控制器
  //
  final StreamController ctrl = StreamController();
//  //
//  //初始化一个只打印数据的监听器
//  //一收到它
//  //
//  final StreamSubscription subscription =
//      ctrl.stream.listen((data) => print('$data'));
//
//  //
//  // 我们在这里添加将会流进Stream中的数据
//  //
//  ctrl.sink.add('my name');
//  ctrl.sink.add(1234);
//  ctrl.sink.add({'a': 'element A', 'b': 'element B'});
//  ctrl.sink.add(123.45);
//
//  ctrl.close();
//


  /**
   * 广播流
   */
  final StreamController<int> ctrl1= StreamController<int>.broadcast();

  final StreamSubscription subscription1 = ctrl1.stream
      .where((value) => (value % 2 == 0))
      .listen((value) => print('$value'));

  ctrl1.stream.listen((value)=>print('------$value'));
  //
  // We here add the data that will flow inside the stream
  //
  for(int i=1; i<11; i++){
    ctrl1.sink.add(i);
  }

  //
  // We release the StreamController
  //
  ctrl1.close();

}
