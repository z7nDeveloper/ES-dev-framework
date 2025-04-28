import 'package:flutter/material.dart';

extension PopupWidgetExtension on Widget {
  showDialogWithWidget(BuildContext context, {
    bool barrierDismissible = true,
    Color? barrierColor,
  }) {
    return showDialog(
        context: context,
        barrierColor: barrierColor, // Colors.black54
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return this;
        });
  }

  showDialogInNextFrame(BuildContext context ) async {

    WidgetsBinding.instance.scheduleFrameCallback((_) {
      showDialogWithWidget(context);
    });
  }
}
