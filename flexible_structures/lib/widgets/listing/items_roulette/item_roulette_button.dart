


import 'package:flexible_structures/widgets/base_templates/buttons/icon_action_card_button.dart';
import 'package:flexible_structures/widgets/interactions/opacity_on_hover.dart';
import 'package:flexible_structures/widgets/interactions/scale_on_hover.dart';
import 'package:flutter/material.dart';

class ItemRouletteButton extends StatelessWidget {
  final Function()? move;
  final IconData icon;
  const ItemRouletteButton({super.key, required this.move,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    Color? buttonBackground = Color(0x136da7db);
    Color? buttonBackgroundHovered = ( Theme.of(context).elevatedButtonTheme
        .style?.backgroundColor?.resolve(Set<MaterialState>()) ??
        Colors.blue);
    //buttonBackground = buttonBackgroundHovered;

    return Container(
      width: 50,
      child: SizedBox.expand(
        child: ScaleOnHover(
          notHovered: Matrix4.diagonal3Values(0.99,0.99, 0.99),
          child: IconActionCardButton(
            /**/backgroundOnlyParent: (context, background) {
            return OpacityOnHover(child: background);
          },
            icon: IgnorePointer(child: Icon(icon)),
            content: '',
            backgroundColor: buttonBackground,
            hoverColor: buttonBackgroundHovered,
            forceMobile: true,
            onPress: move,
          ),
        ),
      ),
    );
  }
}

