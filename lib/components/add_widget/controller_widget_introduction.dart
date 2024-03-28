import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';

const INTERSPACE = 24.0;

class ControllerWidgetIntroduction extends StatelessWidget {
  final ControllerWidgetDef widget;
  ControllerWidgetIntroduction({required this.widget});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: INTERSPACE),
          Text(
            widget.class_.name,
            style: cddTheme.textTheme.headlineLarge,
          ),
          const SizedBox(height: INTERSPACE),
          // Center(child: SvgPicture.asset(getWidgetAsset(widget.class_))),
          const SizedBox(height: INTERSPACE),
          Text(widget.class_.name),
// TODO: codde_doc generator
          // TODO: example ?
        ],
      ),
    );
  }
}
