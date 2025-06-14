extension DateExtensions on DateTime{
  String get dayName {
    List<String> daysOfWeek = [
      'Mon',
      'Tue',
      'Wed',
      'Thurs',
      'Fri',
      'Sat',
      'Sun'
    ];
    return daysOfWeek[weekday - 1];
  }

  bool isSameDate(DateTime date){
    return day == date.day && month == date.month && year == date.year;
  }
}
