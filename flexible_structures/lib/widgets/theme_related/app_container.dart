import 'package:flutter/cupertino.dart';

class AppContainer extends StatelessWidget {
  final Color? color;
  final Widget child;

  const AppContainer({this.color, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:
 //         GetIt.I.get<DevStyleConfiguration>().useDebugColors ? color :
         //true ? color:
          null,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: child,
    );
  }
}
