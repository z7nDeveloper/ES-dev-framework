




import 'package:intl/intl.dart';

extension IntExtension on int {
  String leadZero() {

    NumberFormat formatter = new NumberFormat("00");
    return formatter.format(this);
  }






  static final romanNumerals = <int,Map<int,String>>{
    1 : {3:'M', 2:'C', 1:'X', 0:'I'},
    2 : {3:'MM', 2:'CC', 1:'XX', 0:'II'},
    3 : {3:'MMM', 2:'CCC', 1:'XXX', 0:'III'},
    4 : {2:'CD', 1:'XL', 0:'IV'},
    5 : {2:'D', 1:'L', 0:'V'},
    6 : {2:'DC', 1:'LX', 0:'VI'},
    7 : {2:'DCC', 1:'LXX', 0:'VII'},
    8 : {2:'DCCC', 1:'LXXX', 0:'VIII'},
    9 : {2:'CM', 1:'XC', 0:'IX'},
  };
  String intToRoman() {
    if (this < 1 || this >= 4000) return '';

    var list = toString().split('').map(int.parse).toList();
    var buffer = StringBuffer();
    final len = list.length;

    for (var i = 0; i < len; i++) {
      var digit = list[i];
      if (digit == 0) continue;
      buffer.write(romanNumerals[digit]![len - 1 - i]);
    }

    return buffer.toString();
  }
}
