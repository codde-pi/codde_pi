import 'dart:io';

import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  String? leading;
  Widget? tailing;
  Text title;
  Text? subtitle;
  Function? onTap;
  Function? onLongPress;
  final bool selected;
  ImageTile(
      {super.key,
      this.leading,
      this.tailing,
      required this.title,
      this.subtitle,
      this.selected = false,
      required this.onTap,
      this.onLongPress});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap != null ? onTap!() : null,
      onLongPress: () => onLongPress != null ? onLongPress!() : null,
      child: Semantics(
          selected: selected,
          // TODO: replcae Card + Padding by Ink
          child: Card(
              child: Row(children: [
            leading != null
                ? Image.file(File(leading!), width: 72, height: 72)
                : Image.asset(noImageAsset, width: 72, height: 72),
            Padding(
              padding: const EdgeInsets.all(widgetGutter),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [title, subtitle ?? Container()],
                ),
              ),
            ),
            tailing ?? Container()
          ]))),
    );
  }
}
