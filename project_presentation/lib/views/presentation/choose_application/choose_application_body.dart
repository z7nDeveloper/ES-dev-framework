import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flexible_structures/widgets/animations/opacity_animation.dart';
import 'package:flexible_structures/widgets/display/text_exhibition_container.dart';
import 'package:flexible_structures/widgets/error_report/report_icon.dart';
import 'package:flexible_structures/widgets/graphical_item/graphical_item.dart';
import 'package:flexible_structures/widgets/graphical_item/in_construction/in_contruction_icon.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flexible_structures/widgets/graphical_item/app_logo.dart';
import 'package:flexible_structures/widgets/layout/template_flex_screen.dart';
import 'package:flutter/material.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';

import 'package:flexible_structures/widgets/layout/quadruple_screen.dart';
import 'package:flexible_structures/widgets/theme_related/flexible_theme_colors.dart';
import 'package:get_it/get_it.dart';
import 'package:project_presentation/views/presentation/choose_application/bloc/choose_application_bloc.dart';
import 'package:project_presentation/views/presentation/choose_application/choose_application_footer.dart';
import 'package:project_presentation/views/presentation/choose_application/widgets/about_z7n_card.dart';
import 'package:project_presentation/views/presentation/choose_application/widgets/entrance_action_icon.dart';
import 'package:project_presentation/views/presentation/choose_application/widgets/entrance_buttons.dart';
import 'entrance_actions.dart';
import 'models/application_option.dart';
import 'models/application_option_styling.dart';
import "widgets/system_completeness_progress_bar.dart";

class ChooseApplicationBody extends StatelessWidget {
  final CommonButtonUtility buttonUtility;
  final List<Map<String, dynamic>> entranceActions;
  final Function(BuildContext context)? appbarElement;

  const ChooseApplicationBody({super.key, required this.buttonUtility,
    required this.entranceActions,  this.appbarElement,});

  @override
  Widget build(BuildContext context) {

    bool useLimitedVersion = !isDesktop(); //isDesktopApp(context);

    Theme.of(context);


    return TemplateFlexScreen(
      structureStyle: TemplateFlexStructureStyle(
        footerColor: Container(
          color: Colors.red,
        )
      ),
      enabledRandomColor: false,
      structure: TemplateFlexStructure(

        structurePadding:
        !isDesktopApp(context) ?
            EdgeInsets.symmetric(horizontal: 20)
         :
        EdgeInsets.symmetric(horizontal: 10),
        structureFlex: [0,12,0],
        quadrupleFlex:
        useLimitedVersion ?
        QuadrupleFlex(0,4,0,0) :
       (
           context.width > 1530 ?
               QuadrupleFlex(
                 1,3,0,1
               ) :
           context.width > 1440 ?
           QuadrupleFlex(
               1,4,0,1
           ) :
           QuadrupleFlex(
            1,7, 0, 1
        )),
        appbarEndAppending: ReportIconButton(possibleErrors: [],),

        bodyLeft: Container(
          color:
              false &&
          useLimitedVersion ?
          Colors.red :
          null
          ,
          child: Column(
            children: [
              Container(
                height: 64,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0).copyWith(
                      bottom: 0
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: appbarElement == null ? Container() : appbarElement!(context),
                  ),
                ),
              ),
              Expanded(
                child: ChooseApplicationOptionsPresentation(
                    useLimitedVersion: useLimitedVersion,
                    entranceActionsMap: entranceActions,
                    buttonUtility: buttonUtility),
              ),
              Container(
                height:
                isMobile() ? 70 :
                64,
                child: ChooseApplicationFooter(),
              )
            ],
          ),
        ),
        bodyPadding: EdgeInsets.only(bottom:  6,
        ),
        actionsRight:
        isTablet()
            ? Container() :
            isMobile() ?
                Container()
                :
        ApplicationOptionDescriptionCard(),

      ),);
  }
}

class ApplicationOptionDescriptionCard extends StatelessWidget {
  const ApplicationOptionDescriptionCard({
    super.key,
  });


  @override
  Widget build(BuildContext context) {


    return BlocBuilder<ChooseApplicationBloc, ChooseApplicationState>(builder: (context, state){
      final bloc = context.read<ChooseApplicationBloc>();
      if(bloc.focusedOption == null) {

        return Container();
      }
      return AnimatedOpacity(
        opacity: bloc.focusedOption!.enabled ? 0 : 1,
        duration: Duration(milliseconds: 900),
        child: Card(
            color: GetIt.I.get<FlexibleThemeColors>().getSlightDeactivatedColor(),
            child: TextExhibitionContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  bloc.focusedOption!.enabled ? Container() : Text(
                    bloc.focusedOption!.description ?? bloc.focusedOption!.optionName,
                    style: TextStyle(
                        color:
                        GetIt.I.get<FlexibleThemeColors>().getTextContrastToBackground()
                    ),
                    maxLines: 99,
                  ),
                ],
              ),
            )),
      );
    });
  }
}


class ChooseApplicationOptionsPresentation extends StatelessWidget {
  const ChooseApplicationOptionsPresentation({
    super.key,
    required this.buttonUtility, required this.entranceActionsMap, required  this.useLimitedVersion,
  });

  final CommonButtonUtility buttonUtility;
  final List<Map<String, dynamic>> entranceActionsMap;
  final bool useLimitedVersion;

  @override
  Widget build(BuildContext context) {
    EntranceActionIconConfiguration configuration = EntranceActionIconConfiguration(
      iconSize: 62.0, scale: 2,
    );


    List<ApplicationOption> optionActions = ApplicationOption.fromMapList(
      entranceActionsMap,

    );


    EntranceActions entranceActions = EntranceActions(
      actions: [

        ...optionActions,
        /* ApplicationOption(
            optionName: 'WEBSITE',
            open: (context) {
                const Main().push(context);
                //context.pushNamed("main");
              }, iconPositioningInButton: IconPositioningInButton.leadingAsStack,

          icon:
                GraphicalItem(
                  item: Icons.computer,
                  type: Graphical.icon,
                ) ,

        ),*/
        /*  ApplicationOption(
            optionName: 'MOBILE',
            open: (context) {
              EntranceRoute().push(context);
              }, iconPositioningInButton: IconPositioningInButton.trailingAsStack,
           icon: GraphicalItem(
             item: Icons.send_to_mobile,
             type: Graphical.icon,
           ) ,

        ),*/
      ],
    );


    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // MaxGap(64),

        isMobile() ? AppLogo(
          itemSize: isMobile() ? ItemSize.almostNormal : ItemSize.normal,
        ) :
        Flexible(

            child: Center(child: AppLogo(
              itemSize: isMobile() ? ItemSize.almostNormal : ItemSize.normal,
            ))),

        /* DiagonalDesignEntranceButtons(buttonUtility: buttonUtility,
            entranceActions: entranceActions),*/
        //  MaxGap(40),


        Expanded(
          child: Padding(
            padding:
            isMobile()?
            const EdgeInsets.only(top: 8.0) : EdgeInsets.zero,
            child: Center(
              child: Container(
                alignment: Alignment.center,

                /**/child: EntranceButtons(
                optionStyling: ApplicationOptionStyling(
                    getBackIcon: (ApplicationOption option) {
                      Widget icon = EntranceActionIcon(
                        configuration: configuration,
                        child:
                        (option.icon.render()),
                      );


                      /*if (option.description != null &&
                          option.description!.isNotEmpty) {
                        icon = Tooltip(
                          message: option.description!,
                          child: icon,
                        );
                      }*/

                      return icon;
                    },
                    getIcon: (ApplicationOption option) {

                      if(option.isLocked) {
                        return GraphicalItem(
                            item: Icons.lock,
                            type: Graphical.icon,
                            info: {
                              'color': Colors.blue,
                              'size': configuration.iconSize * 1.5,
                            }
                        ).render();
                      }
                      option.icon.info?['size'] ??= configuration.iconSize;

                      Widget icon = option.appState == ApplicationState.onProgress ?
                      GraphicalItem(
                          item: Icons.construction,
                          type: Graphical.icon,
                          info: {
                            'color': Colors.blue,
                            'size': configuration.iconSize * 1.5,
                          }
                      ).render() : EntranceActionIcon(
                        configuration: configuration,
                        child:
                        (option.icon.render(
                            color:
                            GetIt.I.get<FlexibleThemeColors>().getBlack()

                        )),
                      );
                      return icon;
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /**/
                            icon
                          ]
                      );
                    }

                ),
                entranceActions: entranceActions, buttonUtility: buttonUtility,
              ),
              ),
            ),
          ),
        ),


        SystemCompletenessProgressBar(
            optionActions: optionActions
        ),


      ],
    );
  }


}