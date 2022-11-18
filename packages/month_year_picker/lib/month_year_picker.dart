library month_year_picker;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef MonthSelectorCallback(String month, int year);

const int _yearPickerColumnCount = 3;
const double _yearPickerPadding = 16.0;
const double _yearPickerRowHeight = 52.0;
const double _yearPickerRowSpacing = 8.0;

showMonthYearPicker(BuildContext context,
    {required MonthSelectorCallback monthSelectorCallback,
    Color? selectedColor,
    Color? textColor,
    Color? headerColor,
    Color? headerTextColor,
    int? selectedMonth,
    int? selectedYear}) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
          child: MonthYearSelector(
        monthSelectorCallback: monthSelectorCallback,
        selectedColor: selectedColor ?? Colors.orange,
        textColor: textColor ?? Colors.black87,
        headerColor: headerColor ?? Colors.blue,
        headerTextColor: headerTextColor ?? Colors.white,
        selectedMonth: selectedMonth ?? (DateTime.now().month - 1),
        selectedYear: selectedYear ?? (DateTime.now().year),
      ));
    },
  );
}

class MonthYearSelector extends StatefulWidget {
  final MonthSelectorCallback monthSelectorCallback;
  final Color selectedColor;
  final Color textColor;
  final Color headerColor;
  final Color headerTextColor;
  final int selectedMonth;
  final int selectedYear;

  const MonthYearSelector(
      {Key? key,
      required this.monthSelectorCallback,
      required this.selectedColor,
      required this.textColor,
      required this.headerColor,
      required this.headerTextColor,
      required this.selectedMonth,
      required this.selectedYear})
      : super(key: key);
  @override
  _MonthYearSelectorState createState() => _MonthYearSelectorState();
}

class _MonthYearSelectorState extends State<MonthYearSelector> {
  final List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  final List<int> years = List.generate(50, (i) => DateTime.now().year - 5 + i);

  late int month, year;
  bool isYear = false;
  final _controller = ScrollController();
  static const int _yearPickerColumnCount = 3;
  static const double _yearPickerRowHeight = 52.0;
  static const double decorationHeight = 36.0;
  static const double decorationWidth = 72.0;

  @override
  initState() {
    super.initState();
    month = widget.selectedMonth;
    year = years.indexWhere((element) => widget.selectedYear == element);
  }

  _scrollToIndex() {
    final int initialYearIndex = widget.selectedYear - years[0];
    final int initialYearRow = initialYearIndex ~/ _yearPickerColumnCount;
    // Move the offset down by 2 rows to approximately center it.
    final int centeredYearRow = initialYearRow - 2;
    final double scrollOffset = centeredYearRow * _yearPickerRowHeight;

    _controller.animateTo(scrollOffset,
        duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    switch (orientation) {
      case Orientation.portrait:
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildContent(context),
            buildButtonBar(context)
          ],
        );
      case Orientation.landscape:
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildContent(context),
                  buildButtonBar(context)
                ],
              ),
            ),
          ],
        );
    }
  }

  Widget buildHeader(BuildContext context) {
    return Material(
      color: widget.headerColor,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isYear = false;
                });
              },
              child: Text(
                months[month],
                style: TextStyle(
                  color: widget.headerTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 23,
                  decoration: !isYear ? TextDecoration.underline : null,
                ),
              ),
            ),
            Text(
              "/",
              style: TextStyle(
                  color: widget.headerTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 23),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isYear = true;
                });
                WidgetsBinding.instance
                    ?.addPostFrameCallback((_) => _scrollToIndex());
              },
              child: Text(
                years[year].toString(),
                style: TextStyle(
                  color: widget.headerTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  decoration: isYear ? TextDecoration.underline : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: 210.0,
            width: 500.0,
            child: Theme(
                data: Theme.of(context).copyWith(
                    buttonTheme: ButtonThemeData(
                        padding: EdgeInsets.all(0.0),
                        shape: CircleBorder(),
                        minWidth: 1.0)),
                child: !isYear ? monthsWidget(context) : yearsWidget(context)),
          ),
        ],
      ),
    );
  }

  Widget monthsWidget(BuildContext context) {
    return GridView.extent(
        padding: EdgeInsets.all(12.0),
        physics: ScrollPhysics(),
        maxCrossAxisExtent: 70,
        children: months.asMap().entries.map((m) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              color: month == m.key ? widget.selectedColor : null,
              child: Text(
                m.value,
                style: TextStyle(
                    color: month == m.key ? widget.textColor : Colors.black87),
              ),
              onPressed: () {
                setState(() {
                  month = m.key;
                  isYear = true;
                });
                WidgetsBinding.instance
                    ?.addPostFrameCallback((_) => _scrollToIndex());
              },
            ),
          );
        }).toList());
  }

  Widget yearsWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: GridView.builder(
        controller: _controller,
        gridDelegate: _yearPickerGridDelegate,
        itemBuilder: (context, index) {
          return Container(
            width: decorationWidth,
            height: decorationHeight,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: FlatButton(
                color: year == index ? widget.selectedColor : null,
                child: Text(
                  years[index].toString(),
                  style: TextStyle(
                      color: year == index ? widget.textColor : Colors.black87),
                ),
                onPressed: () {
                  setState(() {
                    year = index;
                  });
                },
              ),
            ),
          );
        },
        itemCount: years.length,
        padding: const EdgeInsets.symmetric(horizontal: _yearPickerPadding),
      ),
    );
  }

  Widget buildButtonBar(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text("CANCEL"),
        ),
        FlatButton(
          onPressed: () {
            widget.monthSelectorCallback(months[month], years[year]);
            Navigator.of(context).pop();
          },
          child: Text("OK"),
        )
      ],
    );
  }
}

class _YearPickerGridDelegate extends SliverGridDelegate {
  const _YearPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double tileWidth = (constraints.crossAxisExtent -
            (_yearPickerColumnCount - 1) * _yearPickerRowSpacing) /
        _yearPickerColumnCount;
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: _yearPickerRowHeight,
      crossAxisCount: _yearPickerColumnCount,
      crossAxisStride: tileWidth + _yearPickerRowSpacing,
      mainAxisStride: _yearPickerRowHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_YearPickerGridDelegate oldDelegate) => false;
}

const _YearPickerGridDelegate _yearPickerGridDelegate =
    _YearPickerGridDelegate();
