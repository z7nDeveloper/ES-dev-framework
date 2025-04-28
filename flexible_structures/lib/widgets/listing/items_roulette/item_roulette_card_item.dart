

import 'package:flexible_structures/widgets/interactions/clickable.dart';
import 'package:flexible_structures/widgets/listing/items_roulette/items_roulette.dart';
import 'package:flutter/material.dart';

class ItemRouletteCardItem<T> extends StatelessWidget {

  final Widget child;
  final double? trackItemSize;
  final RouletteItemStyle? itemStyle;
  final Function(T item)? onItemClicked;

  final T item;
  const ItemRouletteCardItem({super.key, required this.child,
   this.trackItemSize,  this.itemStyle,  this.onItemClicked,
    required this.item
  });

  @override
  Widget build(BuildContext context) {

    Widget itemWidget = child;

    if (itemStyle == RouletteItemStyle.expandedCard) {
      itemWidget = Expanded(child:
      Card(
          shadowColor: Colors.black,
          child: Align(
              alignment: Alignment.center,
              child: itemWidget)));
    }
    if(trackItemSize != null) {
      itemWidget =  Container(
        width: (trackItemSize),
        child: Padding(
          padding:
          EdgeInsets.zero,
          // EdgeInsets.symmetric(horizontal: 6, vertical: isMobile() ? 3 : 0  ),
          child: itemWidget,
        ),
      );
    }

    if(onItemClicked != null) {
      itemWidget = Clickable(
        onPress: () {
          onItemClicked!(item);
        },
        child: itemWidget,
      );
    }

    return itemWidget;

  }
}
