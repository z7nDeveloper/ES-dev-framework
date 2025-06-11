import 'dart:math';

import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flexible_structures/widgets/display/cards/white_box_animated_container.dart';
import 'package:flexible_structures/widgets/graphical_item/app_logo.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './movement_animated_flex.dart';

import 'bloc/navigation_rail_bloc.dart';

class NavigationBarItems {
  final List<BottomNavigationBarItem> items;
  final BottomNavigationBarItem? footerItem;
  final Function()? onFooterSelected;
  final BottomNavigationBarItem? profileItem;
  final BottomNavigationBarItem? homeItem;
  NavigationBarItems({
    required this.items,
    required this.profileItem,
    required this.homeItem,
    required this.onFooterSelected,
    required this.footerItem,
  });
}

class CustomNavigationRail extends StatefulWidget {
  final NavigationBarItems navigationItems;
  final ValueNotifier<int> selectedIndex;
  final ValueChanged<int> onDestinationSelected; 
  final bool useBadgeInDesktop;
  final bool expandsOnHover;
  final bool useTextButtons;
  final ItemSize? logoSmallSize;
  final Function()? onLogoTap;
  final bool lessHorizontalPaddingInMobile;
  final double? outsidePaddingToAvoidOverflow;
  final bool keepSpaceBetweenFooterAndLogo; // if false, removees a spacer that exists between logo and footer
  final bool useExpandedIcons; // if true, uses a space between in the icon list
  const CustomNavigationRail({
    super.key,
    required this.navigationItems,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.useBadgeInDesktop=false,
    this.expandsOnHover=true,
    this.useTextButtons=true,
    this.logoSmallSize,
    this.onLogoTap,
    this.outsidePaddingToAvoidOverflow,
    this.keepSpaceBetweenFooterAndLogo=true,
    this.lessHorizontalPaddingInMobile=false,
    this.useExpandedIcons=false,
  });

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> { 

  @override
  void initState() {
    super.initState(); 



    widget.selectedIndex.addListener(() {
      updateList();
    });

    updateList();
  }

  int getIndex() {
    return widget.selectedIndex.value == -1 ? 0 :
    (widget.selectedIndex.value == 2 ?
    0 :
    (widget.selectedIndex.value + (
        widget.selectedIndex.value > 2 ? 0 : 1
    ))

    );
  }

  @override
  Widget build(BuildContext context) {

    double currentMaxWidth = context.read<NavigationRailBloc>().extended ? 200 : 70;

    return BlocBuilder<NavigationRailBloc, NavigationRailState>(
  builder: (context, state) {
    return Container(
      width: isMobile() ? context.width : null,
      height: isMobile() ? 66 : context.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMobile() ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          MouseRegion(
            onEnter: (_) => setState(() {
              if(widget.expandsOnHover) {

                context.read<NavigationRailBloc>().add(NavigationRailExtended());
              }
            }),
            onExit: (_) => setState(() {
              context.read<NavigationRailBloc>().add(NavigationRailCollapsed());
            }),
            child: WhiteBoxAnimatedContainer(
              width: isMobile()  ? context.width-(
              widget.outsidePaddingToAvoidOverflow ?? 0
              ) :   context.read<NavigationRailBloc>().extended ? 200 : 70,
              height: context.height,
              //constraints: BoxConstraints(maxWidth: 70,),
              child:
              isMobile() ?
              false ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widgetListNotifier.value,
                  ) :
              MovementAnimatedFlex(widgetListNotifier: widgetListNotifier,
                direction: Axis.horizontal,
              ) :
              OverflowBox(
                minWidth: 200,
                maxWidth: 200,
                alignment: Alignment.centerLeft,
                child:

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    if(widget.navigationItems.profileItem != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0,
                      bottom: 64
                      ),
                      child: AnimatedContainer(
                        width: currentMaxWidth,
                        //color: Colors.red,
                        duration: Duration(milliseconds: 300),
                        child: widget.navigationItems.profileItem!.icon,
                      ),
                    ),
                    _buildNavigationIcons(),
                    widget.useExpandedIcons ? SizedBox(
    height: 16,
    ) :
                    Spacer(),

                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: currentMaxWidth,
                      child: Center(
                        child: AppLogo(
                          onTap: widget.onLogoTap,
                          itemSize: context.read<NavigationRailBloc>().extended ? ItemSize.small :
                          (widget.logoSmallSize ?? ItemSize.verySmall),
                          variant: context.read<NavigationRailBloc>().extended ?  null : '_without_name',
                        ),
                      ),
                    ),
                    if(widget.navigationItems.footerItem != null && (widget.keepSpaceBetweenFooterAndLogo))
                    Spacer(),
                    if(widget.navigationItems.footerItem != null)
                    Container(
                        child: _buildDestination(-1,  widget.navigationItems.footerItem!,
                        onTap: widget.navigationItems.onFooterSelected,
                        useBadge: false,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  },
);
  }

  Widget _buildNavigationIcons() {


    List<Widget> icons = [
      if(widget.navigationItems.homeItem != null)
        _buildDestination(0, widget.navigationItems.homeItem!),
      for (int i = 0; i < widget.navigationItems.items.length; i++)
        _buildDestination(i+1, widget.navigationItems.items[i]),

    ];

    if(widget.useExpandedIcons) {
      return Expanded(
        flex: 2,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: icons,
        ),
      );
    }

    return Column(
      children: icons,
    );

  }
  updateList() {
    List<Widget> children = [

      //_buildDestination(0, widget.navigationItems.homeItem),

      if (widget.navigationItems.profileItem != null)
      Padding(
        padding:
        getIndex() != 0 ? const EdgeInsets.only(right: 0.0) :
        const EdgeInsets.only(bottom: 20.0),
        child: InkWell(
          onTap: (){
            widget.onDestinationSelected(0);
          },
          child: AnimatedContainer(
            width:  70,
            duration: Duration(milliseconds: 300),
            child: widget.navigationItems.profileItem!.icon,
          ),
        ),
      ),
      for (int i = 0; i < 2; i++)
        _buildDestination(i+1, widget.navigationItems.items[i]),

      for (int i = 2; i < min(4, widget.navigationItems.items.length); i++)
        _buildDestination(i+1, widget.navigationItems.items[i]),


    ];

    Widget centerWidget = children[getIndex()];
    children.removeAt(getIndex());
    children.insert(2, centerWidget);
    widgetListNotifier.value = children;
  }

  ValueNotifier<List<Widget>> widgetListNotifier = ValueNotifier([]);


  Widget _buildDestination(int index, BottomNavigationBarItem destination, {Function()? onTap, bool? useBadge=null}) {
    bool isSelected = index == widget.selectedIndex;

    Widget destinationContent = Row(
      mainAxisSize:
      widget.useTextButtons ? MainAxisSize.max :
      MainAxisSize.min,
      mainAxisAlignment: isMobile() ? MainAxisAlignment.start : MainAxisAlignment.start,
      children: [
        destination.icon,
        if (!isMobile() &&  context.read<NavigationRailBloc>().extended
          && widget.useTextButtons
        ) ...[
          Spacer(),
          Text(destination.label ?? '', style: TextStyle(
              color: Colors.black //Colors.white
          )),
          Spacer(),
        ],
      ],
    );

    const useDivider = false;

    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile()
          ? 16 :
      useDivider ? 16 :
      24, horizontal:
      (
          widget.lessHorizontalPaddingInMobile &&
          isMobile()) ? 12 :
      24),
      child: Column(
        children: [
          Container(

            decoration: BoxDecoration(
              color: isSelected ?
                  Theme.of(context).primaryColor
                   : Colors.transparent
              //?: Colors.red
              ,
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: onTap ?? () => widget.onDestinationSelected(index),
              child:

              isMobile() || widget.useBadgeInDesktop
                  ?
              (useBadge != null && !useBadge ?
              destinationContent :
              Badge(
                label: Text('0'),
                alignment: Alignment.bottomRight,
                offset: Offset(5, 0),
                child: destinationContent,
              )
              )
                  : destinationContent,
            ),
          ),
          if(useDivider)
          SizedBox(
            height: 12,
          ),
          if(useDivider)
          Divider(),
        ],
      ),
    );
  }
}
