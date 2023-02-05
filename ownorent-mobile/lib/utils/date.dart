import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateTimeFormatter {
  String timeDifference(Timestamp timestamp) {
    var newDate = timestamp.toDate();
    if (DateTime.now().difference(newDate).inSeconds < 60) {
      return '${DateTime.now().difference(newDate).inSeconds}s';
    } else if (DateTime.now().difference(newDate).inSeconds > 60 &&
        DateTime.now().difference(newDate).inMinutes < 60) {
      return '${DateTime.now().difference(newDate).inMinutes}m';
    } else if (DateTime.now().difference(newDate).inMinutes > 60 &&
        DateTime.now().difference(newDate).inHours < 25) {
      return '${DateTime.now().difference(newDate).inHours}h';
    } else if (DateTime.now().difference(newDate).inHours > 24 &&
        DateTime.now().difference(newDate).inDays < 31) {
      return '${DateTime.now().difference(newDate).inDays}d';
    } else {
      return '${(DateTime.now().difference(newDate).inDays / 31).toStringAsFixed(0)}mo';
    }
  }

  String formatDateWithLineBreak(timestamp) {
    var format = DateFormat(' dd\nMMM');
    var newDate = format.format(timestamp.toDate());
    return newDate;
  }

  String displayFullDate(Timestamp timestamp) {
    var format = DateFormat('dd MMM, y');
    return format.format(timestamp.toDate());
  }

  String displayDateWithMMM(timestamp) {
    var format = DateFormat('dd MMM, y');
    return format.format(timestamp);
  }

  String displayTime(timestamp) {
    var format = DateFormat('jm');
    var time = timestamp.toDate();
    var newDate = format.format(time);
    return newDate;
  }

  String displayT(timestamp) {
    var format = DateFormat('jm');
    var time = timestamp;
    var newDate = format.parse(time);

    return format.format(newDate);
  }

  String timeDiff(end, start) {
    var format = DateFormat("HH:mm");
    var one = format.parse(start);
    var two = format.parse(end);

    if (two.difference(one).inMinutes > 59) {
      return "${two.difference(one).inHours}hrs";
    } else {
      return "${two.difference(one).inMinutes}mins";
    }
  }
}
