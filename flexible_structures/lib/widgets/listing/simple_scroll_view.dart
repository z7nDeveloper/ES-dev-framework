


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleScrollView extends StatefulWidget {
  final Widget child;
  final Axis scrollDirection;
  final EdgeInsets scrollPadding;
  final ScrollController? controller;
  const SimpleScrollView({super.key, required this.child,
  required this.scrollPadding,
    this.controller,
  this.scrollDirection=Axis.vertical});

  @override
  State<SimpleScrollView> createState() => _SimpleScrollViewState();
}

class _SimpleScrollViewState extends State<SimpleScrollView> {


  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    scrollController = widget.controller?? scrollController;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      trackVisibility: true,
        thumbVisibility: true,
        controller: scrollController,
        child: Padding(
      padding: widget.scrollPadding,
      child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: widget.scrollDirection,
          child: widget.child),
    ));
  }
}
