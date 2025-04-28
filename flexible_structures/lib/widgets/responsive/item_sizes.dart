import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flutter/cupertino.dart';


enum ItemSize {
  minimal,
  verySmall,
  smallish,
  smallishLarge,
  small,

  normal,
  medium,
  big,

  large,
  unlimited,
}

extension ItemSizeExtension on ItemSize {
  bool isBigger(ItemSize itemSize) {
    return ItemSize.values.indexOf(this) > ItemSize.values.indexOf(itemSize);
  }

  ItemSize whenMobile(ItemSize mobileSize) {
    return isMobile() ? mobileSize : this;
  }


  double get defaultMultiplier {
    return {
      ItemSize.big: 2.0,
     // ItemSize.medium: 1.1,
      ItemSize.small: 0.6,
      ItemSize.smallishLarge: 0.7,
      ItemSize.smallish: 0.5,
    }[this] ?? 1.0;
  }
}

abstract class ItemSizeResolver {
  final ItemSize itemSize;

  ItemSizeResolver(this.itemSize);

  double? resolveWidth(BuildContext context, {dynamic widget});
  double? resolveHeight(BuildContext context, {dynamic widget});
}
