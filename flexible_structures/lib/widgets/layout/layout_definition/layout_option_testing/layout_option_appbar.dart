import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flexible_structures/widgets/theme_related/app_container.dart';
import 'package:flutter/material.dart';


class LayoutOptionsAppbar extends StatelessWidget {
  final ValueNotifier<int> designOption;
  const LayoutOptionsAppbar({Key? key, required this.designOption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: AppContainer(
          color: Colors.yellowAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [LayoutOptionsButton(designOption: designOption)],
          ),
        ),
      ),
    );
  }
}

class LayoutOptionsButton extends StatelessWidget {
  const LayoutOptionsButton({
    super.key,
    required this.designOption,
  });

  final ValueNotifier<int> designOption;

  @override
  Widget build(BuildContext context) {
    return CardButtonV1(
      title: CardTextContent(
        content: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
      onPress: () {
        designOption.value += 1;
      },
      buttonSize: ItemSize.minimal,
    );
  }
}
