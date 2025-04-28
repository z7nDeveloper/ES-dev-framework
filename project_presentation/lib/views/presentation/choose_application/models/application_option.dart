

// view class
import 'package:common_extensions/extensions/ui/for_colors.dart';
import 'package:flexible_structures/widgets/display/dynamic_card.dart';
import 'package:flexible_structures/widgets/graphical_item/graphical_item.dart';
import 'package:flutter/material.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/icon_action_card_button.dart';

import 'package:go_router/go_router.dart';

import '../widgets/entrance_button.dart';


enum ApplicationState {
  complete,
  onProgress,
  blocked,
}

class ApplicationOption implements FavoriteItem {
  final String optionName;
  final Function(BuildContext context) open;
  final IconPositioningInButton iconPositioningInButton;
  final GraphicalItem icon;
  final bool enabled;
  final bool isLocked;

  final Color? backgroundColor;
  final Color? textColor;
  final String? description;

  final ApplicationState appState;


  ApplicationOption(
      {
        required this.optionName,
        required this.open,
        required this.iconPositioningInButton,
        required this.icon,  this.enabled=true,
        this.backgroundColor, this.textColor,
        required this.appState,
        this.description,
        this.isLocked=false,
      });



  static ApplicationOption fromMap(Map<String, dynamic> map, {int? index, Map<String, dynamic>? additionalInfo}) {

    return ApplicationOption(
      isLocked: map['isLocked'] ?? false,
      description: map['description'],
        enabled: map['enabled'] ??true,
        optionName: map['optionName'],
        open: map['open']  ?? (context){
          if(map['route'] == null) {
            return;
          }
          if(additionalInfo != null && additionalInfo["functions"][map['route']] != null) {
            additionalInfo["functions"][map['route']]!(context);
            return;
          }
          context.push(map['route']);
        },
        iconPositioningInButton:
        map['iconPosition'] ??
            ( (index ?? 0) % 2 == 0 ) ?
        IconPositioningInButton.leadingAsStack :
        IconPositioningInButton.trailingAsStack,
        icon: GraphicalItem.fromMap(map['icon']),
        backgroundColor:
        ColorExtension.maybeColor(int.tryParse(map['backgroundColor'] ?? '')),

        textColor: map['textColor'],
        appState: ApplicationState.values.firstWhere((e) => e.name == map['appState'], orElse: () => ApplicationState.complete),

    );
  }

  static List<ApplicationOption> fromMapList(List<Map<String, dynamic>> actions, { Map<String, dynamic>? additionalInfo}) {
    List<ApplicationOption> optionActions = [];

    for(int actionLength = actions.length, i = 0; i < actionLength; i++) {

      optionActions.add(
          ApplicationOption.fromMap(actions[i],
              index: i,
              additionalInfo: additionalInfo,
          ));

    }
    return optionActions;

  }

  @override
  bool favorite = false;
}