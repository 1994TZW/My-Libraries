import 'package:dateformatter/date_data.dart';

class Util {
  static List<DateData> parseDateData(String formatString) {
    assert(formatString != null);
    List<DateData> dateData = [];

    String prevStr = "";
    for (int i = 0; i < formatString.length; i++) {
      String current = formatString[i];
      if (i != 0 && _isEnd(prevStr, current)) {
        dateData.add(DateData.fromString(prevStr));
        prevStr = "";
      }
      prevStr += current;
    }
    if (prevStr != "") dateData.add(DateData.fromString(prevStr));

    return dateData;
  }

  static bool _isEnd(String prevStr, String current) {
    bool isCurrentDate = current == "d" || current == "M" || current == "y" || current == "E";
    String prevChar = prevStr[prevStr.length - 1];
    bool isPrevDate = prevChar == "d" || prevChar == "M" || prevChar == "y" || prevChar == "E";
    bool isEq = prevChar == current;

    if ((isPrevDate && !isCurrentDate) || (!isPrevDate && isCurrentDate)) {
      return true;
    }
    if (isPrevDate && isCurrentDate && !isEq) {
      return true;
    }
    return false;
  }
}
