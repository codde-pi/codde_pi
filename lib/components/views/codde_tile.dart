import 'package:flutter/material.dart';

class CoddeTile extends StatelessWidget {
  Icon? leading;
  Icon? tailing;
  Text title;
  Text? subtitle;
  Function? onTap;
  Function? onLongPress;
  CoddeTile(
      {super.key,
      this.leading,
      this.tailing,
      required this.title,
      this.subtitle,
      required this.onTap,
      this.onLongPress});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap != null ? onTap!() : null,
        onLongPress: () => onLongPress != null ? onLongPress!() : null,
        child: Semantics(
            child: Ink(
                child: Card(
                    child: Row(children: [
          leading ?? Container(),
          Expanded(
              child: Column(
            children: [title, subtitle ?? Container()],
          )),
          tailing ?? Container()
        ])))));
  }
}
