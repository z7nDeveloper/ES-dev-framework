

/*
import 'package:flutter/material.dart';
import 'package:common_extensions/extensions/ui/for_build_context.dart';
/*import 'package:form_components/form_components/dropdown_field.dart';
import 'package:form_components/languages/language_dropdown.dart';*/


class ChooseLanguageBlock extends StatelessWidget {
  const ChooseLanguageBlock({super.key});

  @override
  Widget build(BuildContext context) {


    double imageSize = 20;
return   Container(

        width:  context.width*0.4,
        child: LanguageDropdown(
          menuItemOverlayColor: MaterialStateProperty.resolveWith((states) {
            if(states.contains(MaterialState.hovered)) {
              return Theme.of(context).hoverColor;
            }

            return Theme.of(context).cardColor;
          }),
          items: [
            DropdownItem(value: 'Português'
                ,
                icon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset('assets/images/flags/brasil.jpeg',

                  width: imageSize,),
                )
            ),
            DropdownItem(value: 'Inglês',
                icon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset('assets/images/flags/usa.jpeg',
                  width: imageSize,),
                )
            ),

          ],
          displayBuilder: (DropdownBuilderArgs args) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Icon(Icons.public,
                    size: 16,),
                 ),
                Text(args.selectedItem.getDisplay(),
                  style: Theme.of(context).textTheme.labelMedium,),
               ],
            );
          },
        ));
    return Row(
      children: [
       /* Container(
          constraints: BoxConstraints(
              maxWidth: 120
          ),
          child: TemplateDropdown(
            width: 120,
            args: DropdownBuilderArgs(selectedItem: DropdownItem(value: 'Português')),
          ),
        ),*/

        DropdownField(
          width:  context.width*0.4,
          items: [
            DropdownItem(value: 'Português'
            ,
            icon: Image.asset('assets/images/flags/brasil.jpeg')
            ),
            DropdownItem(value: 'Inglês',
                icon: Image.asset('assets/images/flags/usa.jpeg')
            ),

          ],
          displayBuilder: (DropdownBuilderArgs args) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Icon(Icons.public,
                  size: 16,),
                ),
                Text(args.selectedItem.value.toString(),
                style: Theme.of(context).textTheme.labelMedium,),
              ],
            );
          },
        )
      ],
    );

  }
}
*/