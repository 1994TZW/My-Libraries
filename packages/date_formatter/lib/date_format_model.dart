import 'package:dateformatter/date_data.dart';


class DateFormatModel {
  static List<DateData> days = [
    DateData('d', 'Day (5)', DateType.DAY),
    DateData('dd', 'Day (05)', DateType.DAY),
    DateData('E', 'Day (Fri)', DateType.DAY),
    DateData('EEEE', 'Day (Friday)', DateType.DAY),
  ];
  static List<DateData> months = [
    DateData('M', 'Month (1)', DateType.MONTH),
    DateData('MM', 'Month (01)', DateType.MONTH),
    DateData('MMM', 'Month (Jan)', DateType.MONTH),
    DateData('MMMM', 'Month (January)', DateType.MONTH),
  ];
  static List<DateData> years = [
    DateData('yy', 'Year (30)', DateType.YEAR),
    DateData('yyyy', 'Year (1930)', DateType.YEAR),
  ];

  static List<DisplayDateFormat> formatList = [
    DisplayDateFormat(
      id: 'day',
      name: 'Day',
    ),
    DisplayDateFormat(
      id: 'month',
      name: 'Month',
    ),
    DisplayDateFormat(
      id: 'year',
      name: 'Year',
    ),
    DisplayDateFormat(
      id: 'text',
      name: 'Text',
    ),
  ];
}
