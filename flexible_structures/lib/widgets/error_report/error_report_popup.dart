


import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:flexible_structures/widgets/popups/template_popup.dart';
import 'package:flutter/material.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';



class PossibleError {

  final String name;
  PossibleError({required this.name,});
}

class ErrorReportPopup extends StatelessWidget {

  final List<PossibleError> possibleErrors;
  const ErrorReportPopup({super.key, required this.possibleErrors,});

  @override
  Widget build(BuildContext context) {
    return TemplatePopup(
        popupSize: ItemSize.normal,
        usesScroll: false,
        child: Column(children: [

          Text(
              'Reporte de Erro',
            style: Theme.of(context).textTheme.bodyLarge,
          ),

      Expanded(
        child: Container(
          width: context.width,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Onde foi encontrado um erro?'),
              ),

              Column(
                children: [
                  for(PossibleError possibleError in possibleErrors)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CardButtonV1(
                        onPress: (){

                        },
                        title: CardTextContent(content: possibleError.name)),
                  ),
                ],
              ),
            ],
          ),
        ),
      )

    ],));
  }
}
