import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/codde_widgets/registry/camera_view/camera_stream_component.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

final controllerWidgetDef = {
  'simple_button': ControllerWidgetDef(
      class_: ControllerClass.simple_button,
      description: 'simple button description',
      name: "Simple Button",
      api: [ControllerApiAttribute(key: null, valueType: 'boolean')],
      commitFrequency: ControllerCommitFrequency.triggered,
      painter: (
              {required ColorScheme colorscheme,
              bool? pressed,
              ControllerStyle? style}) =>
          SimpleButtonPainter(
              colorscheme: colorscheme,
              pressed: pressed ?? false,
              style: style),
      player: (
              {required int id,
              required ControllerClass class_,
              ControllerProperties? properties,
              WidgetPainter? painter,
              Vector2? position,
              String? text,
              Vector2? size}) =>
          SimpleButtonPlayer(
              id: id,
              class_: class_,
              painter: painter,
              position: position,
              text: text,
              size: size),
      size: 1),
  'press_button': ControllerWidgetDef(
    class_: ControllerClass.press_button,
    description: 'press button description',
    name: "Press Button",
    api: [ControllerApiAttribute(key: null, valueType: 'boolean')],
    commitFrequency: ControllerCommitFrequency.pressed,
    size: 1,
    painter: (
            {required ColorScheme colorscheme,
            bool? pressed,
            ControllerStyle? style}) =>
        PressButtonPainter(
            colorscheme: colorscheme, pressed: pressed ?? false, style: style),
    player: (
            {required ControllerClass class_,
            required int id,
            ControllerProperties? properties,
            WidgetPainter? painter,
            Vector2? position,
            String? text,
            Vector2? size}) =>
        PressButton(
            id: id,
            class_: class_,
            painter: painter,
            position: position,
            text: text,
            size: size),
  ),
  'directional_button': ControllerWidgetDef(
      class_: ControllerClass.directional_button,
      description: 'directional button description',
      name: "Directional Button",
      api: [ControllerApiAttribute(key: 'number', valueType: 'int')],
      commitFrequency: ControllerCommitFrequency.pressed,
      painter: (
              {required ColorScheme colorscheme,
              bool? pressed,
              ControllerStyle? style}) =>
          DirectionalButtonPainter(
              colorscheme: colorscheme,
              pressed: pressed ?? false,
              style: style),
      player: (
              {required ControllerClass class_,
              required int id,
              ControllerProperties? properties,
              WidgetPainter? painter,
              Vector2? position,
              String? text,
              Vector2? size}) =>
          DirectionalButton(
              id: id,
              class_: class_,
              painter: painter,
              position: position,
              size: size),
      size: 1),
  'unknown': ControllerWidgetDef(
      class_: ControllerClass.unknown,
      description: "Unknown button fallback",
      name: "Unknown button",
      api: [],
      painter: (
              {required ColorScheme colorscheme,
              bool? pressed,
              ControllerStyle? style}) =>
          ErrorPainter(colorscheme: colorscheme, style: style),
      player: (
              {required ControllerClass class_,
              required int id,
              ControllerProperties? properties,
              WidgetPainter? painter,
              Vector2? position,
              String? text,
              Vector2? size}) =>
          UnknownButtonPlayer(
              id: id, class_: class_, painter: painter, position: position),
      size: 0),
  'joystick': ControllerWidgetDef(
      class_: ControllerClass.joystick,
      description: "Unknown button fallback",
      name: "Unknown button",
      api: [],
      painter: (
              {required ColorScheme colorscheme,
              bool? pressed,
              ControllerStyle? style}) =>
          null,
      player: (
              {required ControllerClass class_,
              required int id,
              ControllerProperties? properties,
              WidgetPainter? painter,
              Vector2? position,
              String? text,
              Vector2? size}) =>
          UnknownButtonPlayer(
              id: id, class_: class_, painter: painter, position: position),
      size: 0),
  'camera_view': ControllerWidgetDef(
      class_: ControllerClass.camera_view,
      description: 'This is camera view',
      name: "Camera View",
      api: [],
      painter: (
              {required ColorScheme colorscheme,
              bool? pressed,
              ControllerStyle? style}) =>
          null,
      player: (
              {required ControllerClass class_,
              required int id,
              ControllerProperties? properties,
              WidgetPainter? painter,
              Vector2? position,
              String? text,
              Vector2? size}) =>
          CameraStreamComponent(properties: properties),
      size: 0)
};
