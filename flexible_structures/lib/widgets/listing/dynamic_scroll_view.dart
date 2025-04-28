


import 'package:flutter/cupertino.dart';

// https://stackoverflow.com/questions/56326005/how-to-use-expanded-in-singlechildscrollview
class DynamicScrollView extends StatelessWidget {
  final Widget child;
  final Axis scrollAxis;
  const DynamicScrollView({super.key,
    this.scrollAxis=Axis.vertical,
    required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(scrollDirection: scrollAxis,
      slivers: [
        SliverFillRemaining(
            hasScrollBody: false,
            child: child
        ),
      ],
    );
  }
}
