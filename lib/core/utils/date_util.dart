class DateUtil {
  static String formatToMonthDay(String dateString) {
    final date = DateTime.parse(dateString);
    return "${date.month}월 ${date.day}일";
  }
}
