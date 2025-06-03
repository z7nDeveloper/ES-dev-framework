


import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flutter/material.dart';
import 'package:project_presentation/views/presentation/choose_application/widgets/about_z7n_card.dart';

class ChooseApplicationFooter extends StatelessWidget {
  const ChooseApplicationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: Flex(
        direction: isMobile() ? Axis.vertical : Axis.horizontal ,
        crossAxisAlignment:
        CrossAxisAlignment.center,
        mainAxisAlignment: isMobile() ? MainAxisAlignment.end  : MainAxisAlignment.start,
        children: [
          isMobile() ? Container():
          Spacer(),
          Flexible(
              flex: 2,
              child: Align(
                  alignment: isMobile() ? Alignment.bottomCenter : Alignment.center,
                  child: AboutZ7NCard())),


          Flexible(
              child: Visibility(
                visible: true,//!isMobile(),
                child: Align(
                    alignment:
                    isMobile() ? Alignment.bottomCenter :
                    Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('VERSION 0.0.1',
                      style: Theme.of(context).textTheme.labelMedium,
                      ),
                    )),
              )),
        ],
      ),
    );
  }
}
