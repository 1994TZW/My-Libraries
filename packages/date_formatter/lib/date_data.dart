import 'package:dateformatter/date_format_model.dart';

enum DateType { DAY, MONTH, YEAR, TEXT }

class DateData {
  String format;
  String name;
  DateType dateType;

  get display => dateType == DateType.TEXT ? format : name;

  DateData(this.format, this.name, this.dateType);

  factory DateData.fromString(String format) {
    List<DateData> modelData = [];
    modelData.addAll(DateFormatModel.days);
    modelData.addAll(DateFormatModel.months);
    modelData.addAll(DateFormatModel.years);
    DateData _dateData = modelData.firstWhere((e) => e.format == format,
        orElse: () => DateData(format, format, DateType.TEXT));
    return _dateData;
  }

  @override
  String toString() {
    return "format:$format,name:$name,dateType:$dateType";
  }
}

class DisplayDateFormat {
  final String id;
  final String name;

  DisplayDateFormat({required this.id, required this.name});
}
