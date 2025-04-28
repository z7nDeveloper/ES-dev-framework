


import 'package:flexible_structures/widgets/listing/expanded_widget_vector.dart';
import 'package:flutter/cupertino.dart';

class ExpandedColumn extends StatelessWidget {

  final List<Widget?> children;
  final Alignment? childrenAlignment;
  final int? flex;
  final MainAxisSize? mainAxisSize;
  const ExpandedColumn({super.key,
    this.childrenAlignment,
    this.flex,
    this.mainAxisSize,
  required this.children,});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize:mainAxisSize ?? MainAxisSize.max,
      children: children.map<Widget>((e) {

          if(e == null) {
            return Container();
          }
          if(e is Expanded || e is Flexible || e is Spacer) {
            if(e is Flexible && e.flex == 0) {
              return e.child;
            }
            return e;
          }

          Widget child = e;

          if(flex == 0 )  {
            return child;
          }
          child = Align(

            child:e, alignment:childrenAlignment ?? Alignment.topCenter,
          );

          return Expanded(
              flex: flex ?? 1,
              child: child);
      }).toList(),
    );
  }
}

