import 'package:dateformatter/date_data.dart';
import 'package:flutter/material.dart';

import 'format_chooser.dart';

typedef DeleteFormatCallback = Function(DateData dateData);
typedef ChageFormatCallback = Function(
    DateData oldDateData, DateData newDateData);

class DateFormatWidget extends StatefulWidget {
  final DeleteFormatCallback deleteFormatCallback;
  final ChageFormatCallback changeFormatCallback;
  final DateData dateData;
  final TextStyle? textStyle;
  final Color? chipColor;

  DateFormatWidget({
    required this.deleteFormatCallback,
    required Key key,
    required this.dateData,
    required this.changeFormatCallback,
    this.textStyle,
    this.chipColor,
  })  : assert(dateData != null),
        super(key: key);
  @override
  _DateFormatWidgetState createState() => _DateFormatWidgetState();
}

class _DateFormatWidgetState extends State<DateFormatWidget> {
  DateData? _dateData;

  @override
  void initState() {
    super.initState();
    _dateData = widget.dateData;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var dateData = await showDialog(
            context: context,
            builder: (BuildContext context) =>
                FormatChooser(dateData: this._dateData!));
        if (dateData != null) {
          if (_dateData!.name == dateData.name &&
              _dateData!.format == dateData.format) {
            widget.deleteFormatCallback(widget.dateData);
          } else {
            widget.changeFormatCallback(widget.dateData, dateData);
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Chip(
          backgroundColor:
              widget.chipColor != null ? widget.chipColor : Colors.grey[2100],
          label: Container(
              padding: const EdgeInsets.all(0.0),
              child: Text('${_dateData == null ? "" : _dateData!.display}')),
          labelStyle: widget.textStyle == null
              ? TextStyle(color: Colors.white)
              : widget.textStyle,
          labelPadding: EdgeInsets.all(2.0),
          deleteIcon: Icon(Icons.expand_more),
          onDeleted: () {},
          deleteIconColor: Colors.black,
        ),
      ),
    );
  }
}
