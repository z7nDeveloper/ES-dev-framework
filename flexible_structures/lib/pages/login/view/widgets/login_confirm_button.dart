import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginConfirmButton extends StatelessWidget {
  final Function()? callLogin;
  const LoginConfirmButton({Key? key, required this.callLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return Column(
          children: [
            CardButtonV1(
              key: Key('confirmButton'),
              title: CardTextContent(content: 'Confirmar login'),
              buttonSize: ItemSize.normal,
              cardIntention: CardIntention.action,
              width: CardDimension(nulify: true),
              pressEnabled: form.valid && callLogin != null,
              onPress: callLogin,
            ),
          ],
        );
      },
    );
  }
}
