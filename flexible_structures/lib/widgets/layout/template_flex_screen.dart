import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:flexible_structures/widgets/layout/quadruple_screen.dart';
import 'package:flexible_structures/widgets/theme_related/random_color_list_widget.dart';
import 'package:flexible_structures/widgets/utils/flexible_if_not_null.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../listing/expanded_column.dart';

class TemplateFlexComponent {
  final Widget? widget;
  final EdgeInsets? padding;

  TemplateFlexComponent({
    this.widget,
    this.padding,
  });
}

class TemplateFlexStructure {

  final QuadrupleFlex? quadrupleFlex;
  final QuadrupleFlex? appbarFlex;
  final QuadrupleFlex? footerFlex;

  final EdgeInsets? structurePadding;
  final double? bodyComponentPadding;
  final List<int>? structureFlex;


  final Widget? appbar;
  final Widget? appbarEndAppending;
  final Widget? bodyLeft;
  final Widget? bodyRight;
  final Widget? actionsRight;
  final Widget? actionsLeft;
  final Widget? footer;
  final EdgeInsets? bodyPadding;

  final Widget? bodyLeftBottom;
  final Widget? bodyRightBottom;
  final Widget Function(Widget)? bodyWrapper;
  final Widget Function(Widget)? footerWrapper;
  TemplateFlexStructure({
    this.quadrupleFlex, // left action, left body, right body, right actions
    this.appbar,
    this.footerFlex,
    this.appbarFlex,
    this.appbarEndAppending,
    this.bodyLeft,
    this.bodyRight,
    this.actionsLeft,
    this.bodyWrapper,
    this.footerWrapper,
    this.actionsRight,
    this.footer,
    this.structureFlex,
    this.structurePadding,
    this.bodyPadding,
    this.bodyLeftBottom,
    this.bodyRightBottom,
    this.bodyComponentPadding,
  });

  TemplateFlexStructure mixedWith(TemplateFlexStructure? otherStructure) {
    return TemplateFlexStructure(
      appbar: appbar ?? otherStructure?.appbar,
      bodyWrapper: bodyWrapper ?? otherStructure?.bodyWrapper,
      structurePadding: structurePadding ?? otherStructure?.structurePadding,
      bodyLeft: bodyLeft ?? otherStructure?.bodyLeft,
      bodyRight: bodyRight ?? otherStructure?.bodyRight,
      bodyPadding: bodyPadding ?? otherStructure?.bodyPadding,
      actionsRight: actionsRight ?? otherStructure?.actionsRight,
      actionsLeft: actionsLeft ?? otherStructure?.actionsLeft,
      quadrupleFlex: quadrupleFlex ?? otherStructure?.quadrupleFlex,
      structureFlex: structureFlex ?? otherStructure?.structureFlex,
      appbarFlex: appbarFlex ?? otherStructure?.appbarFlex,
      footerFlex: footerFlex ?? otherStructure?.footerFlex,
      bodyLeftBottom: bodyLeftBottom ?? otherStructure?.bodyLeftBottom,
      bodyRightBottom: bodyRightBottom ?? otherStructure?.bodyRightBottom,
      footer: footer ?? otherStructure?.footer,
      appbarEndAppending:
          appbarEndAppending ?? otherStructure?.appbarEndAppending,
        bodyComponentPadding: bodyComponentPadding ?? otherStructure?.bodyComponentPadding,
    );
  }

  static TemplateFlexStructure twoByTwo({
    required Widget bodyLeft,
    required Widget bodyRight,
    required Widget bodyLeftBottom,
    required Widget bodyRightBottom,
  }) {
    return TemplateFlexStructure(
      quadrupleFlex: QuadrupleFlex(0, 1, 1, 0),
      bodyLeft: bodyLeft,
      bodyRight: bodyRight,
      bodyLeftBottom: bodyLeftBottom,
      bodyRightBottom: bodyRightBottom,
    );
  }

  static TemplateFlexStructure twoByOne({
    required Widget bodyLeft,
    required Widget bodyRight,
  }) {
    return TemplateFlexStructure(
      quadrupleFlex: QuadrupleFlex(0, 1, 1, 0),
      bodyLeft: bodyLeft,
      bodyRight: bodyRight,
    );
  }

  static TemplateFlexStructure fullBodyConfig({
    required Widget bodyLeft,
    required Widget bodyRight,
    Widget? bodyLeftBottom,
    Widget? bodyRightBottom,
  }) {
    return TemplateFlexStructure(
      quadrupleFlex: QuadrupleFlex(0, 1, 1, 0),
      bodyLeft: bodyLeft,
      bodyRight: bodyRight,
      bodyLeftBottom: bodyLeftBottom,
      bodyRightBottom: bodyRightBottom,
    );
  }
}

class TemplateFlexStructureStyle {
  final Color? appbarColor;

  final Widget? bodyLeftColor;
  final Widget? bodyRightColor;
  final Widget? actionsRightColor;
  final Widget? footerColor;

  TemplateFlexStructureStyle(
      {this.appbarColor,
      this.bodyLeftColor,
      this.bodyRightColor,
      this.actionsRightColor,
      this.footerColor});
}

class TemplateFlexScreen extends StatelessWidget {
  final TemplateFlexStructure structure;
  final TemplateFlexStructureStyle? structureStyle;
  final bool enabledRandomColor;

  const TemplateFlexScreen({
    super.key,
    this.structureStyle,
    this.enabledRandomColor = false,
    required this.structure,
  });

  @override
  Widget build(BuildContext context) {
    TemplateFlexStructure usedStructure = structure.mixedWith(defaultStructure);

    return SizedBox(
      width: context.width,
      height: context.height,
      child: LimitedBox(
        maxWidth: 400,
        child: Padding(
          padding: usedStructure.structurePadding ?? const EdgeInsets.all(6.0),
          child: RandomColorListWidget(
            enabled:
                enabledRandomColor, //&& GetIt.I.get<DevStyleConfiguration>().useDebugColors,
            parentBuilder: (children) {
              return Column(
                children: children,
              );
            },
            childrenParentList: (Widget child, int index) {
              return NullSafeFlexible(
                flex: (structure.structureFlex ??
                    [
                      1,
                      12,
                      2,
                    ])[index],
                child: child,
              );
            },
            children: [
              usedStructure.appbar == null
                  ? null
                  : _TemplateAppbar(usedStructure: usedStructure),
              _TemplateFlexBody(usedStructure: usedStructure),
              QuadrupleFlexList(
                quadrupleFlex:  usedStructure?.footerFlex ?? usedStructure?.quadrupleFlex ?? QuadrupleFlex(2, 4, 1, 1),
                leftBody: usedStructure.footer,
                bodyWrapper: usedStructure?.footerWrapper,
              )

            ],
          ),
        ),
      ),
    );
  }

  TemplateFlexStructure? get defaultStructure {
    return null;
    /*
    try {
      return GetIt.I.get<TemplateFlexStructure>();
    }
    catch(err){
      return null;
    }*/
  }
}

class _TemplateAppbar extends StatelessWidget {
  const _TemplateAppbar({
    super.key,
    required this.usedStructure,
  });

  final TemplateFlexStructure usedStructure;

  @override
  Widget build(BuildContext context) {
    return QuadrupleFlexList(
      quadrupleFlex: usedStructure.appbarFlex ?? usedStructure.quadrupleFlex ?? QuadrupleFlex(2, 4, 1, 1),
      leftBody: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          usedStructure.appbar!,
          usedStructure.appbarEndAppending == null
              ? Container()
              : Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [usedStructure.appbarEndAppending!],
                  ),
                )
        ],
      ),
    );
  }
}

class _TemplateFlexBody extends StatelessWidget {
  const _TemplateFlexBody({
    super.key,
    required this.usedStructure,
  });

  final TemplateFlexStructure usedStructure;

  @override
  Widget build(BuildContext context) {
    Widget body = Padding(
      padding: usedStructure.bodyPadding ?? EdgeInsets.zero,
      child: QuadrupleFlexList(
        useEmptySpaceOnRight: true,
        decoration:

//        GetIt.I.get<DevStyleConfiguration>().useDebugColors ?  QuadrupleDecoration.temperatureView() :

            null,
        quadrupleFlex: usedStructure.quadrupleFlex ?? QuadrupleFlex(2, 4, 1, 1),
        leftActions: usedStructure.actionsLeft,
        leftBody: ExpandedColumn(children: [
          usedStructure.bodyLeft,
          Flexible(
            flex: 0,
            child: Container(
              width: usedStructure.bodyComponentPadding,
            ),
          ),
          usedStructure.bodyLeftBottom,
        ]),
        rightBody: ExpandedColumn(children: [
          usedStructure.bodyRight,
          Flexible(
            flex: 0,
            child: Container(
              width: usedStructure.bodyComponentPadding,
            ),
          ),
          usedStructure.bodyRightBottom,
        ]),
        bodyWrapper: usedStructure.bodyWrapper,
        rightActions: usedStructure.actionsRight,
      ),
    );



    return body;
  }
}
