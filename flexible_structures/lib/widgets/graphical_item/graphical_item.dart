import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

enum Graphical { image, icon, svg }



class GraphicalItem {
  final dynamic item;
  final Graphical type;
  Map<String, dynamic>? info;

  GraphicalItem({required this.item, required this.type, this.info});




  Widget render({Color? color, double? size, EdgeInsets? padding}) {
    return renderIcon(this,
    color: color, size: size, padding: padding
    );
  }

  static GraphicalItem fromMap(Map<String, dynamic> map) {


    Graphical graphical = graphicalFromId(map['resource']);
    return GraphicalItem(
      item:
          map['icon'] ??
              (
                  graphical == Graphical.icon ?
                  IconData(map['id'], fontFamily: 'MaterialIcons')
              : map['id']
              ),
      type: graphical,
      info: map.cast<String, dynamic>(),
    );
  }


  static Graphical graphicalFromId(String id) {
    return {
      "svg": Graphical.svg,
      "icon": Graphical.icon,
      "image": Graphical.image,
    }[id] ?? Graphical.icon;
  }

}

Widget renderIcon(GraphicalItem item,
    {Color? color, double? size, EdgeInsets? padding}) {
  if (item.info != null) {
    color = item.info!['color'] ?? color;
    size = item.info!['size'] ?? size;
    padding = item.info!['padding'] ?? padding;
  }

  Widget element;
  switch (item.type) {
    case Graphical.icon:
      if (item.item is Widget) {
        element = item.item;
        break;

      }
      element = Icon(
        item.item,
        color: color,
        size: size,
      );
      break;
    case Graphical.svg:
      if (item.item is Widget) {
        element = item.item;
        break;

      }

      element =
          SvgPicture.asset(
            item.item,
            width: size,
            height: size,
            color: color,
          );

      break;
    case Graphical.image:
      element = Image.asset(item.item);
  }

  return Padding(
    padding: padding ?? EdgeInsets.zero,
    child: element,
  );
}
