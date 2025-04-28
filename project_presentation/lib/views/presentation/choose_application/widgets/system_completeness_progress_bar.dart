import 'package:flutter/material.dart';
import 'package:project_presentation/views/presentation/choose_application/models/application_option.dart';

class SystemCompletenessProgressBar extends StatelessWidget {
  final List<ApplicationOption> optionActions;
const SystemCompletenessProgressBar({Key? key,
required this.optionActions,}) : super(key: key);

@override
Widget build(BuildContext context) {
  double ratioOfCompleteItems =
  optionActions.length == 0 ? 0 :
  optionActions.
  where((element) => element.appState == ApplicationState.complete).toList().length
      /
      optionActions.
      where((element) => element.appState != ApplicationState.blocked).toList().length
  ;
return Padding(
  padding: EdgeInsets.only(top: 20),
  child: Stack(
      alignment: Alignment.center,
      children: [

        LinearProgressIndicator(
          value:ratioOfCompleteItems,
          backgroundColor: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          minHeight: 20,

        ),

        Text(
          'Complete: ${(ratioOfCompleteItems * 100).toStringAsFixed(0)}%',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white
          ),
        )

      ]
  ),
);
}
}
