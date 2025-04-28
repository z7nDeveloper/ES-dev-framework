

import 'package:common_extensions/extensions/ui/for_widget.dart';

import 'package:flexible_structures/widgets/base_templates/buttons/icon_action_card_button.dart';
import 'package:flexible_structures/widgets/error_report/error_report_popup.dart';
import 'package:flutter/material.dart';


class ReportIconButton extends StatelessWidget {
  final List<PossibleError> possibleErrors;
  const ReportIconButton({super.key, required this.possibleErrors,});

  @override
  Widget build(BuildContext context) {
    return IconActionCardButton(content: '',
        //backgroundColor: Colors.red,
     //   useIconInDesktop: true,
        forceMobile: true,
        backgroundColor: true ? Colors.amber :   Colors.grey,
        icon: ReportIcon(), onPress: (){
          ErrorReportPopup(possibleErrors: possibleErrors,).showDialogWithWidget(context);
        });
  }
}

class ReportIcon extends StatelessWidget {
  const ReportIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon( Icons.report_outlined,
    color: Colors.white,);
  }
}
