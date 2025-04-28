
import 'package:flexible_structures/responsive/size_restriction_definition/restricted_size_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:flexible_structures/widgets/base_templates/template_scaffold.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';

import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:project_presentation/views/presentation/choose_application/bloc/choose_application_bloc.dart';
import 'choose_application_body.dart';


class ChooseApplicationPage extends StatefulWidget {
  final List<Map<String, dynamic>> entranceActions;
  final Function(BuildContext context)? appbarElement;

  const ChooseApplicationPage({super.key, required this.entranceActions,  this.appbarElement});

  @override
  State<ChooseApplicationPage> createState() => _ChooseApplicationPageState();
}

class _ChooseApplicationPageState extends State<ChooseApplicationPage> {

  double pageOpacity = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*  pageOpacity = 0;
    Future.delayed(Duration(milliseconds: 1700)).then((value) {
      setState(() {
        pageOpacity = 1;

      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    double cardSize = context.width
        * (!isDesktop() ? 0.6 : 0.25)
    ;

    CommonButtonUtility buttonUtility = CommonButtonUtility(
        itemSize: ItemSize.unlimited,
        border: 28
    );


    Duration opacityAnimation = Duration(milliseconds: 700);

    return TemplateScaffold(
      navbarConfig: NavbarConfiguration.empty(),
      appbarConfig: AppbarConfiguration.empty(),
      useDefaultPadding: false,
      scrollerBehaviour: ScrollerBehaviour.none,
      restrictedSizeProfile: RestrictedSizeProfile.expanded,
      body: BlocProvider(
        create: (context) => ChooseApplicationBloc(),
        child: Container(
          //  color: Colors.white,
          child: ChooseApplicationBody(
            buttonUtility: buttonUtility,
            appbarElement: widget.appbarElement,
            entranceActions: widget.entranceActions,
          ),
        ),
      ),
    );
  }
}




