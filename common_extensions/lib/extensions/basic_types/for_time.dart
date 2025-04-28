


getDisplayableTime(days, hours, minutes) {
  if(days+hours+minutes == 0) {
    return "Recentemente";
  }

  return "Há " + (days > 0 ? "${days} dias" : hours > 0 ? "${hours} horas" : "${minutes} minutos");

}

extension DateTimeExtension on DateTime {

  String asDisplay() {
    int days = day;
    int hours = hour;
    int minutes = minute;
    return getDisplayableTime(days, hours, minutes);
  }
}


extension DurationExtension on Duration {
  String asDisplay() {
    int days = inDays;
    int hours = inHours;
    int minutes = inMinutes;
    return getDisplayableTime(days, hours, minutes);
  }

}
