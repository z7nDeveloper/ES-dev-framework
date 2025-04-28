


import 'package:flutter/material.dart';
import 'package:project_presentation/views/presentation/choose_application/widgets/about_z7n_card.dart';

class ChooseApplicationFooter extends StatelessWidget {
  const ChooseApplicationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Flexible(
              flex: 2,
              child: AboutZ7NCard()),


          Flexible(
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('VERSION 0.0.1'),
                  ))),
        ],
      ),
    );
  }
}
