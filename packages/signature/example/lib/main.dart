import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignPage(),
    );
  }
}

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  ByteData _img = ByteData(0);
  var color = Colors.blue;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();
  late List<Offset> points;

  @override
  void initState() {
    super.initState();
    points = [
      Offset(20.3, 133.3),
      Offset(20.3, 133.3),
      Offset(55.3, 136.3),
      Offset(55.3, 136.3),
      Offset(56.3, 136.3),
      Offset(58.3, 134.3),
      Offset(59.3, 134.3),
      Offset(60.3, 133.3),
      Offset(61.3, 133.3),
      Offset(62.3, 132.3),
      Offset(63.3, 132.3),
      Offset(64.3, 131.3),
      Offset(65.3, 130.3),
      Offset(66.3, 129.3),
      Offset(67.3, 129.3),
      Offset(68.3, 128.3),
      Offset(69.3, 128.3),
      Offset(71.3, 127.3),
      Offset(72.3, 125.3),
      Offset(73.3, 124.3),
      Offset(75.0, 124.3),
      Offset(77.0, 123.3),
      Offset(78.0, 122.3),
      Offset(80.0, 122.3),
      Offset(82.0, 120.3),
      Offset(83.0, 119.3),
      Offset(86.0, 118.3),
      Offset(87.0, 117.3),
      Offset(89.0, 115.3),
      Offset(91.0, 114.3),
      Offset(92.0, 113.3),
      Offset(93.0, 112.3),
      Offset(95.0, 110.3),
      Offset(96.0, 110.3),
      Offset(97.0, 109.3),
      Offset(98.0, 108.3),
      Offset(100.0, 107.3),
      Offset(101.0, 107.3),
      Offset(103.0, 105.3),
      Offset(104.0, 104.3),
      Offset(105.0, 103.3),
      Offset(106.0, 103.3),
      Offset(107.0, 102.3),
      Offset(109.0, 100.3),
      Offset(110.0, 99.3),
      Offset(111.0, 99.3),
      Offset(112.0, 99.3),
      Offset(113.0, 98.3)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signature Pad'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Signature(
                  color: color,
                  key: _sign,
                  points: this.points,
                  onSign: () {
                    final sign = _sign.currentState;
                    // print(sign?.points);
                    // debugPrint('${sign.points.length} points in the signature');
                  },
                  strokeWidth: strokeWidth,
                ),
              ),
              color: Colors.black12,
            ),
          ),
          _img.buffer.lengthInBytes == 0
              ? Container()
              : LimitedBox(
                  maxHeight: 200.0,
                  child: Image.memory(_img.buffer.asUint8List())),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        color: Colors.green,
                        onPressed: () async {
                          final sign = _sign.currentState;
                          final image = await sign?.getData();
                          var data = await image?.toByteData(
                              format: ui.ImageByteFormat.png);

                          Uint8List? buffer = data?.buffer.asUint8List();
                          if (buffer != null) {
                            await Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    appBar: AppBar(),
                                    body: LimitedBox(
                                      maxHeight: 200.0,
                                      child: Image.memory(buffer),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        },
                        child: Text("Select")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        color: Colors.grey,
                        onPressed: () {
                          final sign = _sign.currentState;
                          sign?.clear();
                          setState(() {
                            _img = ByteData(0);
                          });
                        },
                        child: Text("Clear")),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
