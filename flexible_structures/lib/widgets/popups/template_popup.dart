import 'dart:math';

import 'package:flexible_structures/blocs/padding_bloc.dart';
import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flexible_structures/responsive/size_restriction_definition/real_size_bloc.dart';
import 'package:flexible_structures/widgets/listing/multi_child_scroll_view.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// popup class for all application popups
class TemplatePopup extends StatefulWidget {
  final Widget child;
  final Widget Function(BuildContext context)? title;
  final ItemSize popupSize;
  final ItemSize? popupHeight;
  final ItemSize? paddingSize;

  final Color? backgroundColor;
  final Color? contentColor;
  final bool usesScroll;

  final bool usesHeightOnContent;

  final bool useTopPadding;
  final bool useBloc;
  const TemplatePopup(
      {required this.child,
      this.title,
      this.backgroundColor,
      this.contentColor,
      this.paddingSize,
      this.popupSize = ItemSize.big,
      this.popupHeight,
      this.usesHeightOnContent = false,
      this.useTopPadding = false,
      this.usesScroll = true,
      Key? key,
      this.useBloc = false})
      : super(key: key);

  @override
  State<TemplatePopup> createState() => _TemplatePopupState();

  static double scrollerHeightSizeRegulator = 0.72;
}

class _TemplatePopupState extends State<TemplatePopup> {
  resolveContainerWidth() {
    Map<ItemSize, double> sizes = {
      ItemSize.big: min(MediaQuery.of(context).size.width * 0.66, 720),
      ItemSize.normal: 600,
      ItemSize.small: returnAppropriateGlobal(mobile: 320, defaultResult: 344),
      ItemSize.smallish: 220
    };

    return sizes[widget.popupSize] ?? 220;
  }

  resolveContainerHeight() {
    ItemSize popupSize = widget.popupHeight ?? widget.popupSize;

    Map<ItemSize, double> sizes = {
      ItemSize.big: MediaQuery.of(context).size.height,
      ItemSize.normal: 450,
      ItemSize.small: 270,
      ItemSize.smallish: 170
    };
    return min(sizes[popupSize] ?? 220, MediaQuery.of(context).size.height);
  }

  getGlobalPadding() {
    EdgeInsets globalPadding =
        EdgeInsets.all(min(MediaQuery.of(context).size.width * 0.02, 40));

    if (widget.paddingSize != null) {
      globalPadding = globalPadding.copyWith(right: 20);
    }

    return globalPadding;
  }

  getBackgroundColor() {
    return widget.backgroundColor ??
    Theme.of(context).popupMenuTheme.color
        ?? const Color(0xffeeeeee);
  }

  @override
  Widget build(BuildContext context) {
    /*if (screenModelBasedOnWidth() == DeviceType.mobile && usesMobileBlock) {
      context.router.pop();
      return Container(); //
    }*/

    double containerWidth = resolveContainerWidth();
    //containerWidth = MediaQuery.of(context).size.width;

    double containerHeight = resolveContainerHeight();

    EdgeInsets globalPadding = getGlobalPadding();
/**/
    EdgeInsets contentPadding = globalPadding;

    EdgeInsets insetPadding = EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12);

    if (isMobile()) {
      containerWidth = MediaQuery.of(context).size.width;
    }

    if (!widget.useTopPadding) {
      contentPadding = contentPadding.copyWith(top: 0);
    }

    Widget popup = AlertDialog(
      /**/ insetPadding: insetPadding,
      contentPadding: contentPadding,
      backgroundColor: getBackgroundColor(),
      titlePadding: EdgeInsets.only(
          top: 24,
          left: 6,
          right: 6),
      title: widget.title == null ? null : widget.title!(context),
      content: getPopupChild(containerWidth, containerHeight, globalPadding),
    );

    if (!widget.useBloc) {
      return popup;
    }

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return PaddingBloc(globalPadding);
            },
          ),
          BlocProvider(
            create: (context) {
              return SizeCubit(Size(containerWidth, containerHeight));
            },
          ),
        ],
        //#TODO: dynamic padding for popup selection
        child: popup);
  }

  Widget getPopupChild(
      double containerWidth, double containerHeight, EdgeInsets globalPadding) {
    if (!widget.usesScroll) {
      return SizedBox(
          width: containerWidth, height: containerHeight, child: widget.child);
    }

    return Container(
      decoration: getBoxDecoration(),
      child: MultiChildScrollView(
          scrollWidth: containerWidth,
          scrollHeight:
              containerHeight
          //        * TemplatePopup.scrollerHeightSizeRegulator
          ,
          children: [
            SizedBox(
              width: containerWidth,
              height: widget.usesHeightOnContent ? containerHeight : null,
              child: widget.child,
            )
          ]),
    );
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: widget.contentColor,
    );
  }
}

getPopupRadius() {
  return 10;
}
