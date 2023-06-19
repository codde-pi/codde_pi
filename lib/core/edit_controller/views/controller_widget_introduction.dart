import 'package:codde_pi/core/widgets/api/widget_parser.dart';
import 'package:codde_pi/theme.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const INTERSPACE = 24.0;

class ControllerWidgetIntroduction extends StatelessWidget {
  final ControllerWidgetId widget;
  ControllerWidgetIntroduction({required this.widget});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: INTERSPACE),
          Text(
            widget.name,
            style: cddTheme.textTheme.headlineLarge,
          ),
          const SizedBox(height: INTERSPACE),
          Center(child: SvgPicture.asset(getWidgetAsset(widget.class_))),
          const SizedBox(height: INTERSPACE),
          Text(widget.description),
          Table(// TODO:: replace by better DataTable
              children: [
            TableRow(
                children: const ControllerApiAttribute(valueType: 'null')
                    .toJson()
                    .keys
                    .map<Text>((e) => Text(e))
                    .toList()),
            ...widget.api
                .map((e) => TableRow(
                    children: e
                        .toJson()
                        .values
                        .map<Text>((value) => Text(value))
                        .toList()))
                .toList()
          ]),
          // TODO: example ?
        ],
      ),
    );
  }
}
