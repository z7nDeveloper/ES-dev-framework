

import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flexible_structures/responsive/size_restriction_definition/real_size_bloc.dart';
import 'package:flexible_structures/widgets/listing/flexible_listing.dart';
import 'package:flexible_structures/widgets/popups/template_popup.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ActionContentPopup extends StatelessWidget {
  final List<Widget>? top;
  final List<Widget> content;
  final List<Widget> actions;
  final ItemSize? popupSize;
  final ItemSize? popupHeight;
  final CrossAxisAlignment? contentAlignment;
  final MainAxisAlignment? contentColumnAlignment;
  final MainAxisAlignment? actionsAlignment;

  final EdgeInsets buttonsPadding;

  final DeviceOption<Axis>? actionsAxis;
  final Widget Function(BuildContext context)? title;

  final double? proportion;

  final bool usesScroll;

  const ActionContentPopup({
    required this.content,
    this.top,
    this.contentAlignment,
    this.contentColumnAlignment,
    this.popupHeight,
    this.proportion,
    this.buttonsPadding = EdgeInsets.zero,
    required this.actions,
    this.popupSize,
    Key? key,
    this.title,
    this.usesScroll=false,
    this.actionsAlignment, this.actionsAxis,
  }) : super(key: key);

  bool hasTop() {
    return top != null && top!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    double topProportion = 0;
    double contentProportion = proportion ?? 3 / 4;
    double actionsProportion = 1 - contentProportion;

    if (hasTop()) {
      topProportion = 1 / 5;
      contentProportion = 1 / 2;
      //actionsProportion = 1/4;
    }

    return TemplatePopup(
        title: title,
        popupSize: popupSize ?? ItemSize.small,
        popupHeight: popupHeight,
        backgroundColor: Colors.white,
        usesScroll: usesScroll,
        paddingSize: ItemSize.small,
        useBloc: true,
        child: BlocBuilder<SizeCubit, Size>(builder: (context, size) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: contentAlignment ?? CrossAxisAlignment.center,
            children: [
              top == null
                  ? Container()
                  : Container(
                      height: size.height * topProportion,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: top!,
                      ),
                    ),
              Container(
                height: size.height * contentProportion,
                child: Column(
                  mainAxisAlignment:
                      contentColumnAlignment ?? MainAxisAlignment.center,
                  crossAxisAlignment:
                      contentAlignment ?? CrossAxisAlignment.center,
                  children: content,
                ),
              ),
              Container(
              //  alignment: Alignment.centerLeft,
                height: size.height * actionsProportion,
                width: size.width,
                child: FlexibleListing(
                  deviceAxis: actionsAxis ?? DeviceOption(defaultResult: Axis.horizontal),
                    mainAxisAlignment:
                        actionsAlignment ?? MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: actions),
              )
            ],
          );
        }));
  }
}
