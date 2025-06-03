



import 'package:common_extensions/extensions/ui/for_build_context.dart';
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
      child:

      false ? SimpleScrollView(
        scrollDirection: axisOption.getValue(),
        scrollPadding: EdgeInsets.symmetric(vertical: 8),
        child: Container(
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
              elementPadding:  EdgeInsets.all(20),
              children: children
          ),
        ),
      ) :
      ResponsiveWidget(
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
        defaultWidget: Center(
          child: Container(
            width: context.width * 0.8,
            child: ItemsRoulette(
                internalContentPadding: EdgeInsets.symmetric(
                    horizontal: 20
                ),
                useLeftAndRightAnimations: false,
                itemsAtATime: itemsAtATime,
                provideFixating: true,
                isInfinite: true,
                rouletteType: RouletteType.vertical,
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

                  Widget button=  Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        child: EntranceButton(
                            isOnCenter: index == 1,
                            everBeenInCenter: listOfCenteredElements.contains(applicationOption),
                            optionStyling: widget.optionStyling,
                            applicationOption: applicationOption,
                            buttonUtility: widget.buttonUtility),
                      )
                  ) ;

                  if(index != 1) {
                    button = Transform.scale(
                      scale: 0.8,
                      child: button
                    );
                  }

                  return button;
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
        )
      ),
    );
  }
}


class _MobileEntranceButtons extends StatefulWidget {
  final ApplicationOptionStyling optionStyling;
  final CommonButtonUtility buttonUtility;
  final EntranceActions entranceActions;
  final DeviceOption<Axis> axisOption;

  const _MobileEntranceButtons({
    super.key,
    required this.optionStyling,
    required this.buttonUtility,
    required this.entranceActions,
    required this.axisOption,
  });

  @override
  State<_MobileEntranceButtons> createState() => _MobileEntranceButtonsState();
}

class _MobileEntranceButtonsState extends State<_MobileEntranceButtons> {
  ScrollController scrollController = ScrollController();
  List<GlobalKey> keys = [];
  List<bool> isCenteredList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkCenterStates());
    scrollController.addListener(checkCenterStates);
  }

  void checkCenterStates() {
    final List<bool> newCenterStates = [];

    for (var i = 0; i < keys.length; i++) {
      newCenterStates.add(isInCenter(
        itemKey: keys[i],
        scrollContext: context,
      ));
    }

    setState(() {
      isCenteredList = newCenterStates;
    });
  }

  @override
  Widget build(BuildContext context) {
    final actions = widget.entranceActions.actions;
    keys = List.generate(actions.length, (_) => GlobalKey());

    List<Widget> children = List.generate(actions.length, (index) {
      final applicationOption = actions[index];
      final isOnCenter = index < isCenteredList.length ? isCenteredList[index] : false;

      return EntranceButton(
        key: keys[index],
        everBeenInCenter: false,
        isOnCenter: false,
        isOnCenterMobile: isOnCenter,
        optionStyling: widget.optionStyling,
        applicationOption: applicationOption,
        buttonUtility: widget.buttonUtility,
      );
    });

    return SimpleScrollView(
      controller: scrollController,
      scrollDirection: widget.axisOption.getValue(),
      scrollPadding: const EdgeInsets.symmetric(vertical: 8),
      child: FlexibleListing(
        deviceAxis: widget.axisOption,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        elementPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: children,
      ),
    );
  }
}





bool isInCenter({
  required GlobalKey itemKey,
  required BuildContext scrollContext,
  double threshold = 20.0,
}) {
  final RenderBox? itemBox = itemKey.currentContext?.findRenderObject() as RenderBox?;
  final RenderBox? scrollBox = scrollContext.findRenderObject() as RenderBox?;

  if (itemBox == null || scrollBox == null) {
    print('cant identify itemBox or scrollBox to check if item is in center');
    return false;
  }

  final itemOffset = itemBox.localToGlobal(Offset.zero, ancestor: scrollBox).dy;
  final itemHeight = itemBox.size.height;
  final scrollHeight = scrollBox.size.height;

  final itemCenter = itemOffset + itemHeight / 2;
  final scrollCenter = scrollHeight / 2;

  return (itemCenter - scrollCenter).abs() < threshold;
}
