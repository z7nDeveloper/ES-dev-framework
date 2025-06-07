


import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:flexible_structures/widgets/popups/template_popup.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImportantActionPopup extends StatelessWidget {
  final String details;
  final Function()? onConfirm;
  const ImportantActionPopup({super.key, required this.details, this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return TemplatePopup(
      usesScroll: false,
      popupSize: ItemSize.normal,
        child: Column(
          children: [
            Text('Você tem certeza que quer continuar?'),
            Text(details),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CardButtonV1(
                  buttonSize: ItemSize.small,
                  title: CardTextContent(
                  content: 'Cancelar',
                ),
                onPress: () {
                  context.pop();
                },
                ),
                SizedBox(width: 10,),
                CardButtonV1(
                    buttonSize: ItemSize.small, title: CardTextContent(
                  content: 'Confirmar',
                ), onPress: onConfirm)
              ],
            )
          ],
    ),


    );
  }
}
