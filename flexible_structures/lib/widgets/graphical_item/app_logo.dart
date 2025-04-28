

import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/cupertino.dart';


class AppLogo extends StatelessWidget {
  final ItemSize itemSize;
  const AppLogo({
    this.itemSize=ItemSize.normal,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/logo.png',
      height: getHeight(itemSize),
      fit: BoxFit.fill,
      errorBuilder: (_,__,___){
        return Container();
      },
    );
  }

  static double getHeight(ItemSize itemSize) =>
      {
        ItemSize.small: 100.0,
        ItemSize.smallish: 60.0,
      }[itemSize] ?? 160.0;
}
