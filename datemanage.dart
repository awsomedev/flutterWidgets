import 'package:flutter/material.dart';

class DateManager {
  String makeTwo(int i) {
    return i > 9 ? '$i' : '0$i';
  }

  List<String> allMonths = [
    'JAN',
    "FEB",
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];

  String postDate(DateTime date) {
    var day = makeTwo(date.day);
    var month = makeTwo(date.month);
    var year = date.year.toString();
    return '$year-$month-$day';
  }

  String showDate(DateTime date) {
    var day = makeTwo(date.day);
    var month = makeTwo(date.month);
    var year = date.year.toString();
    return '$day-$month-$year';
  }

  String getDM(DateTime date) {
    return '${makeTwo(date.day)} ${allMonths[date.month - 1]}';
  }

  String showTime(TimeOfDay time) {
    print(time.hour);
    var hour = makeTwo(time.hour > 12 ? time.hour - 12 : time.hour);
    if (time.hour == 0) {
      hour = '12';
    }
    var minutes = makeTwo(time.minute);
    var amPm = time.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minutes $amPm';
  }

  String postTime(TimeOfDay time) {
    var hour = makeTwo(time.hour);
    var minutes = makeTwo(time.minute);

    return '$hour:$minutes:00';
  }

  Duration getDuration(DateTime date) {
    if (date.isBefore(DateTime.now())) {
      return Duration(seconds: 0);
    }
    return date.difference(DateTime.now());
  }

  String convertto24(String time) {
    var timeSection = time.split(' ').first;
    var ampm = time.split(' ').last;
    var s = '$timeSection:00${ampm.toUpperCase()}';
    List<String> splitedString = s.split(":");
    String newFormat = splitedString[2].contains("PM")
        ? ((int.parse(splitedString[0]) + 12) == 24
                    ? 0
                    : (int.parse(splitedString[0]) + 12))
                .toString() +
            ':' +
            splitedString[1]
        : splitedString[0] +
            ":" +
            splitedString[1] +
            ":" +
            splitedString[2].substring(0, 2);
    return newFormat;
  }

  DateTime getDateFromSlot(String date, String session, DateTime startDate) {
    if (date.isEmpty) return startDate;
    if (session.isEmpty) return DateTime.parse(date);
    var convertTime = convertto24(session.split(' ').first);
    var tempDate = DateTime.parse(date);
    TimeOfDay time = TimeOfDay(
        hour: int.parse(convertTime.split(':').first),
        minute: int.parse(convertTime.split(':').first));

    return DateTime(
        tempDate.year, tempDate.month, tempDate.day, time.hour, time.minute);
  }

  TimeOfDay get24(String time) {
    if (time.contains('am') || time.contains('pm')) {
      var initialTime = time.contains('pm') ? 12 : 0;
      var minInString = time.split(' ').first.split(':').last;
      var hrInString = time.split(' ').first.split(':').first;
      var hr = int.parse(hrInString) + initialTime;
      var min = int.parse(minInString);
      // print(time);
      // print('${hr} ${min} \n');
      return TimeOfDay(hour: hr, minute: min);
    } else {
      var hr = int.parse(time.split(':').first);
      var min = int.parse(time.split(':').last);
      // print(time);
      // print('${hr} ${min} \n');
      return TimeOfDay(hour: hr, minute: min);
    }
  }
}
