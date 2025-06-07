

import 'package:flexible_structures/widgets/graphical_item/graphical_item.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../interactions/clickable.dart';


class AppLogo extends StatelessWidget {
  final ItemSize itemSize;
  final String? variant;
  final Function? onTap;

  static String filetype = 'png';

  final String? imageFileType;
  const AppLogo({
    this.variant,
    this.onTap,
    this.imageFileType,
    this.itemSize=ItemSize.normal,
    super.key});

  @override
  Widget build(BuildContext context) {


    String theFileType = imageFileType ?? filetype;

    String path = 'assets/logo' + (variant ?? '') + '.' + theFileType;


    Widget child = GraphicalItem(item:  path,
      info: {
        'fit': BoxFit.fill,
        'height': getHeight(itemSize),
        'fit': BoxFit.contain,
        'errorWidget': (BuildContext context, Object error, StackTrace? stackTrace) {
    return GraphicalItem(
      type: Graphical.image,
    item: 'assets/no_logo.png',
    info: {
    'fit': BoxFit.contain,
    'height': getHeight(itemSize),
    }
    ).render();
        }
      },
      type:
      theFileType == 'svg' ? Graphical.svg :
      Graphical.image,
    ).render();


    if(onTap != null) {
      child = Clickable(
        onPress: () => onTap!(),
        child: child,
      );
    }


    return child;

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
