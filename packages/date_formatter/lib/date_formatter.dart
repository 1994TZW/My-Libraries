library dateformatter;

export 'package:dateformatter/date_formatter_controller.dart';
import 'package:dateformatter/date_data.dart';
import 'package:dateformatter/date_formatter_controller.dart';
import 'package:dateformatter/util.dart';
import 'package:flutter/material.dart';

import 'date_format_model.dart';
import 'date_format_widget.dart';

// ignore: must_be_immutable
class DateFormatter extends StatefulWidget {
  late DateFormatterController controller;
  late Color backgroundColor;
  late TextStyle labelStyle;
  late Color chipBackgroundColor;

  DateFormatter(
      {Key? key,
      String? initialFormatString,
      DateFormatterController? controller,
      Color? backgroundColor,
      Color? chipBackgroundColor,
      TextStyle? labelTextStyle})
      : assert(initialFormatString == null || controller == null),
        super(key: key) {
    this.controller = controller == null
        ? DateFormatterController(
            formatString:
                initialFormatString == null ? "" : initialFormatString)
        : controller;

    this.backgroundColor =
        backgroundColor == null ? Colors.grey.shade200 : backgroundColor;

    this.labelStyle = labelTextStyle == null
        ? TextStyle(color: Colors.white)
        : labelTextStyle;
    this.chipBackgroundColor =
        chipBackgroundColor == null ? Colors.lightBlue : chipBackgroundColor;
  }

  @override
  _DateFormatterState createState() => _DateFormatterState();
}

class _DateFormatterState extends State<DateFormatter> {
  List<DateData> dateData = [];

  @override
  void initState() {
    super.initState();
    String input = widget.controller.formatString;
    this.dateData = Util.parseDateData(input);
  }

  List<Widget> buildList() {
    return dateData
        .map((e) => DateFormatWidget(
              key: Key(e.hashCode.toString()),
              textStyle: widget.labelStyle,
              chipColor: widget.chipBackgroundColor,
              deleteFormatCallback: (data) {
                setState(() {
                  dateData.remove(data);
                  _change();
                });
              },
              changeFormatCallback: (oldData, newData) {
                List<DateData> _result = [];
                dateData.asMap().forEach((i, data) {
                  if (data.hashCode == oldData.hashCode) {
                    _result.add(newData);
                  } else {
                    _result.add(data);
                  }
                });
                setState(() {
                  dateData = List.from(_result);
                });
                _change();
              },
              dateData: e,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: <
        Widget>[
      Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: widget.backgroundColor),
              width: 200,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: buildList(),
              ),
            )),
            Column(
              children: [
                Container(
                  child: IconButton(
                    icon: Icon(Icons.expand_more),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                height: 230,
                                width: 400,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'DATE FORMAT',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Container(
                                        height: 150.0,
                                        child: new ListView.builder(
                                            itemCount: DateFormatModel
                                                .formatList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return showDateFormatList(
                                                  context,
                                                  index,
                                                  DateFormatModel
                                                      .formatList[index]);
                                            })),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }

  showDateFormatList(
      BuildContext context, int index, DisplayDateFormat format) {
    return InkWell(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Text(format.name),
        ),
        onTap: () {
          setState(() {
            switch (index) {
              case 0:
                dateData.add(DateFormatModel.days[0]);
                break;
              case 1:
                dateData.add(DateFormatModel.months[0]);
                break;
              case 2:
                dateData.add(DateFormatModel.years[0]);
                break;
              case 3:
                dateData.add(DateData("-", "", DateType.TEXT));
                break;
            }
            Navigator.pop(context);
            _change();
          });
        });
  }

  _change() {
    String value =
        dateData.fold<String>("", (prev, e) => prev + e.format).toString();
    widget.controller.formatString = value;
  }
}
