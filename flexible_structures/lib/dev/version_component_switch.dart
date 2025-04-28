import 'package:flutter/material.dart';

class VersionComponentSwitch extends StatefulWidget {
  final Widget Function(BuildContext context, int v) builder;
  final int maxVersion;
  final int? startVersion;
  final bool enabled;
  const VersionComponentSwitch({Key? key, required this.builder, required this.maxVersion,
    this.enabled=true,
  this.startVersion}) : super(key: key);

  @override
  State<VersionComponentSwitch> createState() => _VersionComponentSwitchState();
}

class _VersionComponentSwitchState extends State<VersionComponentSwitch> {


  int version = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    version = widget.startVersion ?? version; 
  }

  @override
  Widget build(BuildContext context) {

    if(!widget.enabled) {
      return widget.builder(context, version);
    }
    return Stack(
      children: [
        widget.builder(context, version),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: (){
                  setState(() {
                    version = (version + 1) % widget.maxVersion;
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      (version+1).toString() +'/' + (widget.maxVersion).toString()
                    ),
                  ),
                ),
            ),
          ],
        ),
      ],
    );
  }
}
