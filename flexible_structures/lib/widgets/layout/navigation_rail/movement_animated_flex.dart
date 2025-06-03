

import 'package:flutter/material.dart';

class MovementAnimatedFlex extends StatefulWidget {
  final ValueNotifier<List<Widget>> widgetListNotifier;
  final Axis direction;

  MovementAnimatedFlex({
    required this.widgetListNotifier,
    this.direction = Axis.horizontal,
  });

  @override
  _MovementAnimatedFlexState createState() => _MovementAnimatedFlexState();
}

class _MovementAnimatedFlexState extends State<MovementAnimatedFlex> {
  late List<Widget> _currentList;

  @override
  void initState() {
    super.initState();
    _currentList = widget.widgetListNotifier.value;
    widget.widgetListNotifier.addListener(_updateList);
  }

  void _updateList() {
    setState(() {
      _currentList = List.from(widget.widgetListNotifier.value);
    });
  }

  @override
  void dispose() {
    widget.widgetListNotifier.removeListener(_updateList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flex( 
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      direction: widget.direction,
      children: List.generate(_currentList.length, (index) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _currentList[index],
          transitionBuilder: (child, animation) {
            return SlideTransition(position: animation.drive(Tween(
              begin: Offset(1, 0),
              end: Offset.zero,
            )), child: child);
          },
        );
      }),
    );
  }
}

