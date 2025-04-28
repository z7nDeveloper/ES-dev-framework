
import 'package:flutter/material.dart';

class DateDisplay extends StatelessWidget {
  final DateTime? time;
  final Color? fontColor;
  const DateDisplay({super.key, required this.time,  this.fontColor, });

  @override
  Widget build(BuildContext context) {

    if(time == null) {
      return Container();
    }
    return Text(time!.day.toString().padLeft(2, '0') + '/' +
        time!.month.toString().padLeft(2, '0') + '/' + time!.year.toString() + ' - ' +
        time!.hour.toString().padLeft(2, '0') + ':' + time!.minute.toString().padLeft(2, '0'),

      style: TextStyle(
        color: fontColor ?? Colors.white,
        fontWeight: FontWeight.bold,

      ),
    );
  }
}

