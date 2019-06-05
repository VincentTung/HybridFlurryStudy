import "package:intl/intl.dart";

class TimeUtil {
  static String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('y-M-d HH:mm a');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = diff.inHours.toString() + "小时前";
      } else if (diff.inMinutes > 0) {
        time = diff.inMinutes.toString() + "分钟前";
      } else if (diff.inSeconds > 0) {
        time = diff.inMinutes.toString() + "秒前";
      } else {
        time = "刚刚";
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + "天前";
      } else {
        time = format.format(date);
      }
    } else {
      time = format.format(date);
    }

    return time;
  }
}
