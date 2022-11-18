import 'package:dateformatter/date_data.dart';
import 'package:flutter/material.dart';

import 'date_format_model.dart';

class FormatChooser extends StatefulWidget {
  final DateData dateData;

  const FormatChooser({Key? key, required this.dateData}) : super(key: key);
  @override
  _FormatChooserState createState() => _FormatChooserState();
}

class _FormatChooserState extends State<FormatChooser> {
  final TextEditingController _controller = new TextEditingController();

  List data = [];
  bool isText = false;
  String title = '';
  @override
  void initState() {
    if (widget.dateData.dateType == DateType.DAY) {
      data = DateFormatModel.days;
      title = 'DAY FORMAT';
    } else if (widget.dateData.dateType == DateType.MONTH) {
      data = DateFormatModel.months;
      title = 'MONTH FORMAT';
    } else if (widget.dateData.dateType == DateType.YEAR) {
      data = DateFormatModel.years;
      title = 'YEAR FORMAT';
    }
    isText = widget.dateData.dateType == DateType.TEXT;
    if (isText) {
      _controller.text = widget.dateData.format;
      title = 'TEXT FORMAT';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 270,
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Text('$title',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            isText
                ? Expanded(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: 'Enter Character: / , - ',
                              icon: Icon(Icons.text_format)),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
                            child: Text("OK"),
                            color: Colors.grey[300],
                            onPressed: () {
                              Navigator.pop<DateData>(
                                  context,
                                  DateData(_controller.text, _controller.text,
                                      DateType.TEXT));
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: Container(
                      height: 150,
                      child: new ListView.builder(
                          itemCount: this.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pop<DateData>(
                                    context, this.data[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: new Text(this.data[index].name),
                              ),
                            );
                          }),
                    ),
                  ),
            Divider(
              color: Colors.grey,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                  onTap: () {
                    isText
                        ? Navigator.pop<DateData>(
                            context,
                            DateData(_controller.text, _controller.text,
                                DateType.TEXT))
                        : Navigator.pop<DateData>(context, widget.dateData);
                  },
                  child: Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text("Delete"))),
            )
          ],
        ),
      ),
    );
  }
}
