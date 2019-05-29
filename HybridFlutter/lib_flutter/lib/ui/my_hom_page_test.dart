import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const MethodChannel methodChannel =
  MethodChannel('samples.flutter.io/battery');
  static const EventChannel eventChannel =
  EventChannel('samples.flutter.io/charging');

  static const MethodChannel testMethodChannel =
  MethodChannel('samples.flutter.io/test');

  String _batteryLevel = 'Battery level: unknown.';
  String _chargingStatus = 'Battery status: unknown.';

  String display = "点我调用java方法";
  String display2 = "I am text";

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await methodChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level: $result%.';
    } on PlatformException {
      batteryLevel = 'Failed to get battery level.';
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  ///返回java数据
  Future<String> returnToJava() async {
    return 'result From Flutter';
  }
  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
    testMethodChannel.setMethodCallHandler((MethodCall call) {
      if (call.method == 'flutter_method1') {
        setState(() {
          display2 = "java调用了flutter_method1";
        });

        return returnToJava();

      }
    });
  }

  void _onEvent(Object event) {
    setState(() {
      _chargingStatus =
      "Battery status: ${event == 'charging' ? '' : 'dis'}charging.";
    });
  }

  void _onError(Object error) {
    setState(() {
      _chargingStatus = 'Battery status: unknown.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_batteryLevel, key: const Key('Battery level label')),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  child: const Text('Refresh'),
                  onPressed: _getBatteryLevel,
                ),
              ),
              MaterialButton(
                child: Text(display),
                onPressed: () async {
                  await testMethodChannel
                      .invokeMethod('method1')
                      .then((result) => {
                    setState(() {
                      display = result;
                    })
                  });
                },
              ),
              Text(display2)
            ],
          ),
          Text(_chargingStatus),
        ],
      ),
    );
  }
}
