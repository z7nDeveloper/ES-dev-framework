
import 'package:flexible_structures/widgets/base_templates/generic_navigator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GoBackButton extends StatelessWidget {
  final Function()? defaultGoBack;
  final IconData? icon;
  final double? size;

  static Function()? goBackReplacer;

  static Function(BuildContext)? systemDefaultGoBack;

  final Function()? onGoBack;

  final Function()? goBack;

  final AlignmentGeometry? alignment;
  final bool minimalizeSpace;

  GoBackButton(
      {Key? key,
      this.defaultGoBack,
      this.icon,
      this.goBack,
      this.onGoBack,
      this.size,
        this.minimalizeSpace=false,
      this.alignment})
      : super(key: key);

  static Color? buttonColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    double iconSize = size ?? 22;
    return IconButton(
      icon: Icon(
        icon ?? Icons.arrow_back,
        size: iconSize,
        color: buttonColor,
      ),
      iconSize: iconSize + 8 * (minimalizeSpace ? 0 : 1),
      alignment: alignment ?? (
          minimalizeSpace ? Alignment.centerLeft :
          Alignment.center),
      onPressed: () async {
        if (onGoBack != null) {
          onGoBack!();
        }

        if (goBack != null) {
          goBack!();
          return;
        }

        if (goBackReplacer != null) {
          goBackReplacer!();
          return;
        }


        if (!await GetIt.I.get<GenericNavigator>().pop(context)) {
          if (defaultGoBack == null && systemDefaultGoBack == null) {
            GetIt.I.get<GenericNavigator>().moveToDefault(context);
            return;
          }
          if(defaultGoBack != null) {

            defaultGoBack!();
            return;
          }

          systemDefaultGoBack!(context);

          return;
        }
      },
    );
  }
}
