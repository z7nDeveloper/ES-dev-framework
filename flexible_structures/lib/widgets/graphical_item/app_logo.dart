

import 'package:flexible_structures/widgets/graphical_item/graphical_item.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/cupertino.dart';


class AppLogo extends StatelessWidget {
  final ItemSize itemSize;
  final String? variant;

  static String filetype = 'png';
  const AppLogo({
    this.variant,
    this.itemSize=ItemSize.normal,
    super.key});

  @override
  Widget build(BuildContext context) {

    String path = 'assets/logo' + (variant ?? '') + '.' + filetype;


    return GraphicalItem(item:  path,
      info: {
        'fit': BoxFit.fill,
        'height': getHeight(itemSize),
        'errorWidget': (BuildContext context, Object error, StackTrace? stackTrace) {
    return GraphicalItem(
      type: Graphical.image,
    item: 'assets/no_logo.png',
    info: {
    'fit': BoxFit.fill,
    'height': getHeight(itemSize),
    }
    ).render();
        }
      },
      type:
      filetype == 'svg' ? Graphical.svg :
      Graphical.image,
    ).render();

  }


  static double getHeight(ItemSize itemSize) =>
      {
        ItemSize.small: 100.0,
        ItemSize.almostNormal: 140.0,
        ItemSize.smallish: 60.0,
        ItemSize.verySmall: 40.0,
        ItemSize.minimal: 20.0
      }[itemSize] ?? 160.0;
}
