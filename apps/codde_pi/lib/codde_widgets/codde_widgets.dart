import 'package:codde_pi/components/sheets/widget_details_sheet.dart';
import 'package:flame/game.dart';

import 'registry/registry.dart';
import 'package:flame/components.dart';

import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart' hide Frame;
import 'package:flutter/material.dart';

import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';

import 'models/controller_widget_def.dart';

export 'registry/registry.dart';
export 'models/controller_map.dart';
export 'models/controller_widget_def.dart';

part 'templates/components/widget_editor.dart';
part 'templates/base/widget_component.dart';
part 'templates/base/widget_painter.dart';
part 'templates/base/flame_codde_protocol.dart';

part 'api/widget_parser.dart';
part 'api/utils.dart';
part 'api/codde_com.dart';

part 'templates/mixin/has_material.dart';
part 'templates/components/widget_dummy.dart';
part 'templates/mixin/has_tiled.dart';
part 'templates/mixin/has_codde_protocol.dart';

part 'models/controller_properties.dart';
part 'models/controller_class.dart';
part 'models/controller_style.dart';
