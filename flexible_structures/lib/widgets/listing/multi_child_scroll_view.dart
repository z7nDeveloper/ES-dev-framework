import 'package:flutter/material.dart';

class MultiChildScrollView extends StatefulWidget {
  // Multichild size is obrigatory
  final double? scrollWidth;
  final double? scrollHeight;
  final ScrollbarOrientation direction;

  final EdgeInsets? contentPadding;

  final List<Widget> children;
  final ScrollController? controller;

  final Axis scrollDirection;
  final double? axisSpacing;

  final bool doubleDirection;
  final Alignment alignment;

  final double? heightSpacing;

  MultiChildScrollView(
      {Key? key,
      this.scrollWidth,
      this.scrollHeight,
      this.alignment = Alignment.center,
      this.doubleDirection = false,
      this.contentPadding,
      this.scrollDirection = Axis.vertical,
      this.direction = ScrollbarOrientation.right,
      required this.children,
      this.axisSpacing,
        this.controller,
      this.heightSpacing})
      : super(key: key) {

  }

  @override
  State<MultiChildScrollView> createState() => _MultiChildScrollViewState();
}

class _MultiChildScrollViewState extends State<MultiChildScrollView> {
  ScrollController? scrollController = ScrollController();
  ScrollController secondScrollController = ScrollController();


  double get scrollWidth => widget.scrollWidth ??  MediaQuery.of(context).size.width;

  double get scrollHeight => widget.scrollHeight ??  MediaQuery.of(context).size.height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.controller != null) {
      scrollController = widget.controller!;
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size;

    Widget child = Container(
      width: scrollWidth,
      height: scrollHeight,
      child: getListView(),
    );

     //return child;
/*
    child = SingleChildScrollView(
      child: child,
      controller: scrollController,
    );*/
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      //trackVisibility: true,
      scrollbarOrientation: widget.direction,
      child: child,
    );
  }

  Widget getListView() {
    Axis mainAxis = (widget.direction == ScrollbarOrientation.bottom ||
            widget.direction == ScrollbarOrientation.top)
        ? Axis.horizontal
        : Axis.vertical;

    Widget listView = SizedBox(
      width: scrollWidth,
      height:scrollHeight,
      child: ListView(
          scrollDirection: mainAxis,
          controller: scrollController,
          children: [
            Padding(
              padding: widget.contentPadding ?? EdgeInsets.zero,
              child: Flex(
                  direction: widget.scrollDirection,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    for (Widget child in widget.children)
                      Align(
                        alignment: widget.alignment,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: widget.heightSpacing ?? 0),
                          child: child,
                        ),
                      )
                  ]),
            ),
          ]),
    );

    if (widget.doubleDirection) {
      listView = Scrollbar(
        controller: secondScrollController,
        scrollbarOrientation: mainAxis == Axis.horizontal ?
            ScrollbarOrientation.bottom
            : ScrollbarOrientation.right,
        child:

           listView,
      );
    }

    if (widget.contentPadding != null) {
      listView =
          Padding(padding: widget.contentPadding ?? EdgeInsets.zero, child: listView);
    }

    return listView;
  }
}
