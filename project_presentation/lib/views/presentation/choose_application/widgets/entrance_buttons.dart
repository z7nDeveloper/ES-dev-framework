



import 'package:flexible_structures/responsive/responsive.dart';
import 'package:flexible_structures/widgets/display/background_card.dart';
import 'package:flexible_structures/widgets/listing/simple_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';

import 'package:flexible_structures/widgets/listing/flexible_listing.dart';
import 'package:flexible_structures/widgets/listing/items_roulette/items_roulette.dart';

import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flexible_structures/widgets/theme_related/app_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_presentation/views/presentation/choose_application/bloc/choose_application_bloc.dart';

import 'package:project_presentation/views/presentation/choose_application/entrance_actions.dart';
import 'package:path/path.dart';

import '../models/application_option.dart';
import '../models/application_option_styling.dart';
import 'entrance_button.dart';





class EntranceButtons extends StatefulWidget {
  final EntranceActions entranceActions;
  final CommonButtonUtility buttonUtility;
  final ApplicationOptionStyling optionStyling;
  const EntranceButtons({super.key,
    required this.buttonUtility,
    required this.optionStyling,
    required this.entranceActions});

  @override
  State<EntranceButtons> createState() => _EntranceButtonsState();
}

class _EntranceButtonsState extends State<EntranceButtons> {

  List<ApplicationOption> listOfCenteredElements = []; 

  @override
  Widget build(BuildContext context) {



    DeviceOption<Axis> axisOption = DeviceOption(defaultResult: Axis.horizontal,
        tablet: Axis.vertical,
        mobile: Axis.vertical);

    List<Widget> children = [
      for(ApplicationOption applicationOption in widget.entranceActions.actions)
        EntranceButton(
            everBeenInCenter: false,
            isOnCenter: false,
            optionStyling: widget.optionStyling, applicationOption: applicationOption, buttonUtility: widget.buttonUtility),
    ];

    /*return SingleChildScrollView(
      child:Row(
        children: children,
      ),
    );*/


    final itemsAtATime = 3;
    return BackgroundCard(
      child: ResponsiveWidget(
        desktop: Container(
          child: ItemsRoulette(
            internalContentPadding: EdgeInsets.symmetric(
              horizontal: 20
            ),
              useLeftAndRightAnimations: false,
            itemsAtATime: itemsAtATime,
            provideFixating: true,
            isInfinite: true,
            itemBuilder: (applicationOption, index) {


              if(applicationOption.appState == ApplicationState.blocked) {
                return Container();
              }

              if(index == 1 && !listOfCenteredElements.contains(applicationOption)) {
                listOfCenteredElements.add(applicationOption);
              }

              if(index == 1) {
                final indexInOriginalList = widget.entranceActions.actions.indexOf(applicationOption);
                listOfCenteredElements = listOfCenteredElements.where(
                    (element) => (indexInOriginalList - widget.entranceActions.actions.indexOf(element)).abs() <= 1
                ).toList();

                final bloc = context.read<ChooseApplicationBloc>();
                bloc.add(FocusOnOptionEvent(
                  focusedOption: applicationOption,
                ));
              }

              return  Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: EntranceButton(
                    isOnCenter: index == 1,
                      everBeenInCenter: listOfCenteredElements.contains(applicationOption),
                      optionStyling: widget.optionStyling,
                      applicationOption: applicationOption,
                      buttonUtility: widget.buttonUtility)
                ) ;


            },
            parentBuilder: (List<Widget> children) {
              return SizedBox(
                  child: AppContainer(
                  color: Colors.yellow,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                )
              );
            },
            items: widget.entranceActions.actions,
              cardWidthBuilder: (item, index, spaceIndex) {
                print(spaceIndex);
                if(index == 1) {
                  return 500 * 0.6;
                }
                return 440 * 0.67;
              }
            //cardWidth: 460,
          ),
        ),
        defaultWidget: SimpleScrollView(
          scrollDirection: axisOption.getValue(),
          scrollPadding: EdgeInsets.symmetric(vertical: 8),
          child: FlexibleListing(
           // crossAxisAlignment: CrossAxisAlignment.start,
            deviceAxis: axisOption,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
            //isLandscape() ?
            MainAxisAlignment.center
              //  : MainAxisAlignment.start,
              ,
            crossAxisAlignment: CrossAxisAlignment.center,
            elementPadding:
              EdgeInsets.all(20),
            children: children
          ),
        ),
      ),
    );
  }
}

