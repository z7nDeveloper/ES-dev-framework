


import 'package:common_extensions/extensions/ui/for_widget.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:flexible_structures/widgets/popups/important_action_popup.dart';
import 'package:flutter/material.dart';

class ImportantButton extends StatelessWidget {
  final actionContent;
  final String details;
  final Function()? onPress;
  const ImportantButton({super.key, this.actionContent, this.onPress, required this.details});

  @override
  Widget build(BuildContext context) {
    return CardButtonV1(

        title: CardTextContent(
      content: actionContent
    ),

      onPress: () {
        ImportantActionPopup(
          details: details,
          onConfirm: onPress,
        ).showDialogWithWidget(context);
      },
    );
  }
}
