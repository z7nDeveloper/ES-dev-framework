
import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
class ColorSwitchController extends StatefulWidget {
  final List<Color> colorsAvailable;
  final bool enabled;
  final Function(BuildContext context, Color colorPicked) builder;
  const ColorSwitchController({Key? key,
  required this.colorsAvailable,
  required this.enabled,
  required this.builder,
  }) : super(key: key);

  @override
  _ColorSwitchControllerState createState() => _ColorSwitchControllerState();
}

class _ColorSwitchControllerState extends State<ColorSwitchController> {


  Color pickerColor = Colors.white;

  bool opened = false;

  initState() {
    if(widget.colorsAvailable.isNotEmpty){
      pickerColor = widget.colorsAvailable.first;
    }
  }
  onColorChanged(newColor) {
   setState((){
      pickerColor = newColor;
   });
  }


  @override
  Widget build(BuildContext context) {

    if(!widget.enabled) {
      return widget.builder(context, pickerColor);
    }
    return Stack(
      children: [
        widget.builder(context, pickerColor),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: (){
                  setState(() {
                    opened = !opened;
                  });
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    color: pickerColor,
                    border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text('C')),
                )
            ),
            Visibility(
              visible: opened,
              child: ColorPicker(
                pickerColor: pickerColor,
                  onColorChanged: onColorChanged,
              ),
            ),
            Visibility(
              visible: opened,
              child: Row(
              children: [
                for(var color in widget.colorsAvailable)
                  InkWell(
                    onTap: (){
                      setState(() {
                        pickerColor = color;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),

                          border: Border.all(color: Colors.black)
                      ),
                      width: 20,
                      height: 20,
                    )
                  )
              ],
            ),)
          ],
        )
      ]
    );
  }
}
