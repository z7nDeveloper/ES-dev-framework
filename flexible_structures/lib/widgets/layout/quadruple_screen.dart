




import 'package:flexible_structures/widgets/utils/flexible_if_not_null.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



// leftActions, bodyLeft, bodyRight, rightActions
// bodyLeft + bodyRight = body

// size relation: 1, 3, 3, 1

class QuadrupleDecoration {
  final Color? leftColor;
  final Color? rightColor;
  final Color? leftActionColor;
  final Color? rightActionColor;
  final Color? titleColor;
  final bool forDebug;

  QuadrupleDecoration({
    this.leftColor,
    this.rightColor,
    this.leftActionColor,
    this.titleColor,
    this.rightActionColor,
    this.forDebug=false,
});


  static QuadrupleDecoration temperatureView() {
    return QuadrupleDecoration(
      leftActionColor: Colors.blue,
      leftColor: Colors.green,
      rightColor: Colors.orange,
      rightActionColor: Colors.red,
    );
  }
}

class QuadrupleFlex {
  int firstFlex;
  int secondFlex;
  int thirdFlex;
  int forthFlex;


  QuadrupleFlex(this.firstFlex, this.secondFlex, this.thirdFlex, this.forthFlex,);
}

class QuadrupleScreen extends StatelessWidget {
  final Widget? title;
  final Widget? leftActions;
  final Widget? rightActions;
  final Widget? leftBody;
  final Widget? rightBody;
  final double? topPadding;
  final int? leftFlex;
  final int? bodyFlex;
  final QuadrupleDecoration? decoration;
  final int? actionsFlex;

  final Widget Function(Widget)? bodyWrapper;
  final QuadrupleFlex? quadrupleFlex;


  const QuadrupleScreen({super.key,
    this.topPadding,
    this.actionsFlex,
    this.leftFlex,
    this.title,
    this.decoration,
    this.quadrupleFlex,
    this.bodyFlex,
    this.bodyWrapper,
    this.leftActions, this.rightActions, this.leftBody, this.rightBody});

  @override
  Widget build(BuildContext context) {


    QuadrupleDecoration? usedDecoration = decoration;
    usedDecoration = null;

    /*if(!GetIt.I.get<DevStyleConfiguration>().useDebugColors &&
    decoration?.forDebug == true) {
      usedDecoration = null;
    }*/

    return  Padding(
      padding: EdgeInsets.only(top:  topPadding ?? 0),
      child: Column(
      //  mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          NullSafeFlexible(flex: 2, child: title,
          //useExpanded: false,
         //     useSpaceWhenEmpty: false,
              parent: (child)=> Container(
                color: usedDecoration?.titleColor,
                child: child,
              )
          ),
          Expanded(
            flex: 9,
            child: QuadrupleFlexList(leftActions: leftActions, leftFlex: leftFlex,
                actionsFlex: actionsFlex, decoration: usedDecoration,
                leftBody: leftBody, bodyFlex: bodyFlex, rightBody: rightBody,
                bodyWrapper: bodyWrapper,
                rightActions: rightActions),
          ),
        ],
      ),
    ) ;
  }
}

class QuadrupleFlexList extends StatelessWidget {
  const QuadrupleFlexList({
    super.key,
     this.leftActions,
     this.leftFlex,
     this.actionsFlex,
     this.decoration,
     this.leftBody,
     this.bodyFlex,
     this.rightBody,
     this.rightActions,
    this.quadrupleFlex,
    this.useEmptySpaceOnRight=false,
    this.bodyWrapper,
  });

  final Widget? leftActions;
  final int? leftFlex;
  final int? actionsFlex;
  final QuadrupleDecoration? decoration;
  final Widget? leftBody;
  final int? bodyFlex;
  final Widget? rightBody;
  final Widget? rightActions;

  final bool useEmptySpaceOnRight;
  final QuadrupleFlex? quadrupleFlex;
  final Widget Function(Widget)? bodyWrapper;

  @override
  Widget build(BuildContext context) {

    Widget rightBodyWidget = NullSafeFlexible(child: rightBody, flex:
    quadrupleFlex?.thirdFlex ??
        bodyFlex ?? 7,
        useSpaceWhenEmpty: useEmptySpaceOnRight,
        parent: (child)=> Container(
          color: decoration?.rightColor,
          child: child,
        )
    );

    Widget leftBodyWidget = NullSafeFlexible(child: leftBody, flex:
    quadrupleFlex?.secondFlex ??
        bodyFlex ?? 7,
        parent: (child)=> Container(
          color: decoration?.leftColor,
          child: child,
        )
    );

    return Row(
      //mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NullSafeFlexible(child: leftActions,
          flex:
          quadrupleFlex?.firstFlex ??
          leftFlex ?? actionsFlex ?? 1, useSpaceWhenEmpty: true,
            parent: (child)=> Container(
              color: decoration?.leftActionColor,
              child: child,
            )
        ),


        if(bodyWrapper == null)
          leftBodyWidget,
        if(bodyWrapper == null)
          rightBodyWidget,
        bodyWrapper != null ?
        bodyWrapper!(
            Row(
              children: [
                leftBodyWidget,
                rightBodyWidget
              ],
            )
        ) : Container(),

        NullSafeFlexible(child: rightActions, flex:
        quadrupleFlex?.forthFlex ??  actionsFlex ?? 1,useSpaceWhenEmpty: true,
            parent: (child)=> Container(
              color: decoration?.rightActionColor,
              child: child,
            )
        ),
      ],
    );
  }
}









