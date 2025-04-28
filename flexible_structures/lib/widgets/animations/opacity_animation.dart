


import 'package:flutter/material.dart';

class OpacityOnTimeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration durationToWait;
  const OpacityOnTimeAnimation({super.key, required this.child, required this.duration, required this.durationToWait});

  @override
  State<OpacityOnTimeAnimation> createState() => _OpacityAnimationState();
}

class _OpacityAnimationState extends State<OpacityOnTimeAnimation> {


  double currentOpacity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(widget.durationToWait).then((_){
      setState(() {
        currentOpacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(opacity: currentOpacity, duration: widget.duration,
    child: widget.child,
    );
  }
}
