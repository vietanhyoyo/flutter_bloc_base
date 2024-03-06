class Helper {
  ///Add zero for number
  static String addZeroIfNeeded(int number) {
    String input = number.toString();
    if (input.length == 1) {
      return '0$input';
    } else {
      return input;
    }
  }

  ///Display hour from hour:minute --> HH:mm
  static String displayHour(int hour, int minute) {
    return "${addZeroIfNeeded(hour)}:${addZeroIfNeeded(minute)}";
  }
}
