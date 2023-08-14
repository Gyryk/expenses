String dateToString(DateTime time) {
  String year = time.year.toString();
  String month = time.month.toString();
  if (month.length <= 1) {
    month = "0" + month;
  }
  String date = time.day.toString();
  if (date.length <= 1) {
    date = "0" + date;
  }

  String finalDate = year + month + date;
  return finalDate;
}

String dateToMonth(DateTime time) {
  String month = time.month.toString();
  if (month.length <= 1) {
    month = "0" + month;
  }
  return time.year.toString() + month;
}
