


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:flexible_structures/widgets/interactions/clickable.dart';
import 'package:get_it/get_it.dart';

import 'package:go_router/go_router.dart';
import 'package:flexible_structures/widgets/theme_related/flexible_theme_colors.dart';


class AboutZ7NCard extends StatelessWidget {
  const AboutZ7NCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPress: (){
        /*context.push(
          AboutRoute().routePath,
        );*/
      },
      colorOnHover: GetIt.I.get<FlexibleThemeColors>().getDeactivatedColor(),
      child: Container(
        width: context.width,
      //  height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(style: Theme.of(context).textTheme.bodySmall, title: 'Z7N',
                          textColorForTitle: Colors.white70,
                        ),
                      ),*/
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SvgPicture.asset(
                    'assets/Z7N_Logo.svg',
                    semanticsLabel: 'Z7N Logo',
                    height: 40,
                  ),
                ),
                Padding(padding: EdgeInsets.all(2)),
                Text('Software Development',
                  style: Theme.of(context).textTheme.bodySmall,),



              ],
            ),
            /* Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                width: 190,
                height: 3,
                color: Colors.grey,
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
