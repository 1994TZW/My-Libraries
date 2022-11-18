import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modal Date Picker HUD Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () => showMonthYearPicker(context,
              textColor: Colors.white,
              selectedYear: 2062, monthSelectorCallback: (month, year) {
            print("Month:$month, Year:$year");
          }),
          child: Text("Month picker"),
        ),
      ),
    );
  }
}