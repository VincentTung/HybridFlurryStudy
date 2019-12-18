
import 'dart:async';

import 'block_provider.dart';

class IncrementBloc implements BlocBase {
  int _counter;

  //
  // Stream来处理计数器
  //
  StreamController<int> _counterController = StreamController<int>.broadcast();

  StreamSink<int> get _inAdd => _counterController.sink;

  Stream<int> get outCounter => _counterController.stream;

  //
  //  Stream来处理计数器上的操作
  //
  StreamController _actionController = StreamController();

  StreamSink get incrementCounter => _actionController.sink;

  //
  // Constructor
  //
  IncrementBloc() {
    _counter = 0;
    _actionController.stream.listen(_handleLogic);
  }

  void dispose() {
    _actionController.close();
    _counterController.close();
  }

  void _handleLogic(data) {
    _counter = _counter + 1;
    _inAdd.add(_counter);
  }
  void _testData(data){
    print('-------$data');
  }
}
