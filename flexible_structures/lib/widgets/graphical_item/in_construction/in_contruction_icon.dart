import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum InConstructionAnimation { all, none }

class InConstructionIcon extends StatefulWidget {
  const InConstructionIcon({
    super.key,
    required this.size,
    this.animationMode = InConstructionAnimation.all,
  });

  final InConstructionAnimation animationMode;
  final ItemSize size;

  @override
  State<InConstructionIcon> createState() => _InConstructionIconState();
}

class _InConstructionIconState extends State<InConstructionIcon>
    with SingleTickerProviderStateMixin {
  Animation<Color?>? animation;
  AnimationController? controller;
  double rotation = 0;
  bool toggled = true;

  static Duration duration = const Duration(seconds: 1);

  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: duration, vsync: this);
    animation = ColorTween(begin: Colors.blue, end: Color(0xffD27FBB))
        .animate(controller!)
      ..addListener(colorUpdate);

    if (widget.animationMode == InConstructionAnimation.all) {
      animateColor();

      WidgetsBinding.instance.scheduleFrameCallback((_) {
        if(!mounted) return;
        setState(() {
          rotation += pi;
        });
      });
    }
  }

  void colorUpdate() {
    if (!_isDisposed && mounted) {
      setState(() {
        // The state that has changed here is the animation object’s value.
      });
    } else {
      animation?.removeListener(colorUpdate);
    }
  }

  void animateColor() async {
    if (_isDisposed || !mounted) return;

    if (toggled) {
      controller?.forward();
    } else {
      controller?.reverse();
    }
    toggled = !toggled;

    await Future.delayed(Duration(seconds: (duration.inSeconds).toInt()));
    if (!_isDisposed) {
      animateColor();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    controller?.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    Icon icon = Icon(
      Icons.settings,
      color: animation?.value ?? Colors.blue,
      size: {
            ItemSize.big: 64.0,
            ItemSize.medium: 48.0,
            ItemSize.normal: 32.0,
            ItemSize.small: 12.0
          }[widget.size] ??
          12.0,
    );
    return AnimatedRotation(
        turns: rotation,
        onEnd: () {
          if (!mounted) {
            return;
          }
          rotation += pi;
          setState(() {});
        },
        duration: Duration(seconds: 5),
        child:icon);
  }
}
