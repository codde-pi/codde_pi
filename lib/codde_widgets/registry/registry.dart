import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter_codde_protocol/flutter_codde_protocol.dart';
import 'package:flame_mjpeg/flame_mjpeg.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

import 'package:flame/input.dart';

part 'click_button/click_button_painter.dart';
part 'click_button/click_button.dart';
part 'directional_button/directional_button.dart';
part 'directional_button/directional_button_arrow.dart';
part 'directional_button/directional_button_painter.dart';
part 'directional_button/directional_button_arrow_painter.dart';
part 'error/error_painter.dart';
part 'error/error_widget.dart';
part 'press_button/press_button.dart';
part 'press_button/press_button_painter.dart';
part 'camera_view/camera_stream_component.dart';
part 'joystick/joystick.dart';

final controllerWidgetDef = {
  'clickButton': ControllerWidgetDef(
      class_: ControllerClass.clickButton,
      description: 'simple button description',
      name: "Click Button",
      commitFrequency: ControllerCommitFrequency.triggered,
      command: const WidgetRegistry.clickButton(),
      component: (
              {required int id,
              required ControllerClass class_,
              required ControllerProperties properties,
              Vector2? position,
              Vector2? size,
              String? text,
              required ControllerStyle style}) =>
          ClickButton(
              id: id,
              class_: class_,
              position: position,
              properties: properties,
              size: size,
              style: style,
              text: text)),
  'pressButton': ControllerWidgetDef(
      class_: ControllerClass.pressButton,
      description: 'simple button description',
      name: "Click Button",
      commitFrequency: ControllerCommitFrequency.triggered,
      command: const WidgetRegistry.pressButton(pressed: false),
      component: (
              {required int id,
              required ControllerClass class_,
              required ControllerProperties properties,
              Vector2? position,
              Vector2? size,
              String? text,
              required ControllerStyle style}) =>
          ClickButton(
              id: id,
              class_: class_,
              position: position,
              text: text,
              style: style,
              properties: properties)),
  'directionalButton': ControllerWidgetDef(
    class_: ControllerClass.directionalButton,
    description: 'directional button description',
    name: "Directional Button",
    commitFrequency: ControllerCommitFrequency.pressed,
    command: const WidgetRegistry.directionalButton(direction: 0),
    component: (
            {required int id,
            required ControllerClass class_,
            required ControllerProperties properties,
            Vector2? position,
            Vector2? size,
            String? text,
            required ControllerStyle style}) =>
        DirectionalButton(
            id: id,
            class_: class_,
            position: position,
            size: size,
            properties: properties),
  ),
// create error entry
  'error': ControllerWidgetDef(
    class_: ControllerClass.error,
    description: 'Error widget',
    name: "Error",
    commitFrequency: ControllerCommitFrequency.pressed,
    command: null,
    response: const ResultRegistry.errorResult(error: ''),
    component: (
            {required int id,
            required ControllerClass class_,
            required ControllerProperties properties,
            Vector2? position,
            Vector2? size,
            String? text,
            required ControllerStyle style}) =>
        ErrorWidget(
            id: id, class_: class_, position: position, properties: properties),
  ),
  'joystick': ControllerWidgetDef(
    class_: ControllerClass.joystick,
    description: "Unknown button fallback",
    name: "Unknown button",
    command:
        WidgetRegistry.joystick(delta: toCoord(Vector2.zero()), intensity: 0),
    component: (
            {required int id,
            required ControllerClass class_,
            required ControllerProperties properties,
            Vector2? position,
            Vector2? size,
            String? text,
            required ControllerStyle style}) =>
        Joystick(
            id: id, class_: class_, position: position, properties: properties),
  ),
  'cameraView': ControllerWidgetDef(
      class_: ControllerClass.cameraView,
      description: 'This is camera view',
      name: "Camera View",
      command: null,
      defaultProperties: ControllerProperties(
          {'uri': Property(name: 'uri', type: PropertyType.string, value: '')}),
      component: (
              {required int id,
              required ControllerClass class_,
              required ControllerProperties properties,
              Vector2? position,
              Vector2? size,
              String? text,
              required ControllerStyle style}) =>
          CameraStreamComponent(class_: class_, id: id, properties: properties))
};
