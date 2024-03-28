import 'dart:math';

import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:json_table/json_table.dart';
import 'package:pie_chart/pie_chart.dart';

part 'card_disk.dart';
part 'card_cpu.dart';
part 'card_mem.dart';
part 'card_voltage.dart';
part 'card_temp.dart';
part 'card_tasks.dart';
part 'card_base.dart';

const levelRed = 1.25;
const levelOrange = 1.5;
const gridMargin = 8.0;
const chartWidth = 16.0;
const maxTemp = 85.0;

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
