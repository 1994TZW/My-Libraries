import 'package:dateformatter/date_formatter.dart';
import 'package:dateformatter/date_formatter_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateFormatterController _formatterController = DateFormatterController();
  String showFormat = '';

  void initState() {
    super.initState();
    _formatterController.formatString = "yyyy-MM-dd";
    _formatterController.addListener(() {
      print("listener:${_formatterController.formatString}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Date formatter demo'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: <Widget>[
            DateFormatter(
              controller: _formatterController,
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  // print(
                  //     "Final format string:${_formatterController.formatString}");
                  setState(() {
                    showFormat = _formatterController.formatString;
                  });
                },
                child: Text("Save")),
            SizedBox(height: 30),
            Text('${DateFormat(showFormat).format(DateTime.now())}')
          ],
        ));
  }
}
