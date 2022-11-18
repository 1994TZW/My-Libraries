import 'package:flutter/material.dart';
import 'package:pin_code_input/pin_code_input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pin Code Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: PinCodeInput(
          keyboardType: TextInputType.number,
          length: 6,
          itemSize: 50,
          cursorColor: Colors.redAccent,
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          onCompleted: (String value) {
            print("Value>>>>$value");
          },
        ),
      ),
    );
  }
}