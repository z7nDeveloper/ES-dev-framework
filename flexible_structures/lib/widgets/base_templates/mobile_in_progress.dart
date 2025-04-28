
import 'package:flexible_structures/widgets/graphical_item/in_construction/in_contruction_icon.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flexible_structures/widgets/base_templates/template_scaffold.dart';

class InProgress extends StatefulWidget {

  static bool inView = true;

  const InProgress({Key? key})
      : super(key: key);

  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress>{





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InConstructionIcon(size: ItemSize.normal,),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Text(
                    "Versão MOBILE",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Em construção!",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
