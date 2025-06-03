


import 'package:flutter/material.dart';

class OnHover extends StatefulWidget {

  final Widget Function(bool isHovered) builder;

  final ValueNotifier<bool>? hoverNotifier;
  const OnHover({Key? key, required this.builder, this.hoverNotifier}) : super(key: key);

  @override
  _OnHoverState createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> {

  bool isHovered = false;
  @override
  Widget build(BuildContext context) {

    final hovered = Matrix4.identity()..translate(0.0,-10,0);
    final transform = isHovered ? hovered : Matrix4.identity();

    return MouseRegion(
      onEnter: (_)=> onEntered(true),
      onExit: (_)=> onEntered(false),
      child: widget.builder(isHovered),
    );
  }

  void onEntered(bool isHovered){
    if(widget.hoverNotifier != null){
      widget.hoverNotifier!.value = isHovered;
    }
    setState(() {
      this.isHovered = isHovered;
    });
  }
}