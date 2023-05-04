import 'dart:io';

import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:rxdart/subjects.dart';
import 'package:xml/xml.dart';

part 'controller_widget_repository.dart';

class ControllerWidgetApi {
  ControllerWidgetApi();

  final controllerWidgetStreamController =
      BehaviorSubject<List<ControllerWidget>>.seeded(const []);

  Stream<List<ControllerWidget>> getWidgets() {
    return controllerWidgetStreamController.asBroadcastStream();
  }

  /* Future<ControllerMap> openMap(String path) async {
    File file = new File(path);
    final document = XmlDocument.parse(file.readAsStringSync());
    final layer = document
        .findElements('layer')
        .map((XmlElement e) => ControllerLayer(
            id: e.getAttribute('id'),
            data: e.getAttribute('data').split(',').map((e) => int.parse(e)).toList(), // FIXME: encoding
            size: Size(e.getAttribute('width'), e.getAttribute('height')),
            x: e.getAttribute('offsetx'),
            y: double.parse(e.getAttribute('offsety')),))
        .toList();
    if (layer.isEmpty) {
      throw ControllerWidgetInvalidTiled;
    }
    final tilesets = document.findElements('tileset'),
    ControllerMap map = ControllerMap(path: path, layer: layer.first, backgrounds: tilesets);
    return map;
  } */

  Future<FileSystemEntity>? deleteMap(ControllerMap map) {
    return File(map.path).delete();
  }

  Future<void> removeWidget(String id) async {
    final todos = [...controllerWidgetStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == id);
    if (todoIndex == -1) {
      throw ControllerWidgetNotFoundException();
    } else {
      todos.removeAt(todoIndex);
      controllerWidgetStreamController.add(todos);
    }
  }

  ControllerWidget modifyWidget(ControllerWidget newVersion) {
    final files = [...controllerWidgetStreamController.value];
    final index = files.indexWhere((element) => newVersion.id == element.id);
    if (index == -1) {
      throw ControllerWidgetNotFoundException;
    }
    files.replaceRange(index, index, [newVersion]);
    controllerWidgetStreamController.add(files);

    return newVersion;
  }

  List<ControllerWidget> parseLayers(List<Layer> layers) {
    Iterable<ControllerWidget?> widgets = layers.map((layer) {
      if (layer.id != null) {
        return ControllerWidget(
            id: layer.id!,
            background: null,
            class_: EnumToString.fromString(
                ControllerClass.values, layer.class_ ?? ''),
            name: layer.name,
            position: ControllerPosition(layer.x, layer.y));
      }
    });
    List<ControllerWidget> nullSafetyWidgets = [
      for (var element in widgets)
        if (element != null) element
    ];
    addAll(nullSafetyWidgets);
    return nullSafetyWidgets;
  }

  ControllerWidget addWidget(ControllerWidget widget) {
    // file list stream event
    final files = [...controllerWidgetStreamController.value];
    files.add(widget);
    controllerWidgetStreamController.add(files);

    return widget;
  }

  List<ControllerWidget> addAll(List<ControllerWidget> widgets) {
    // file list stream event
    final files = [...controllerWidgetStreamController.value];
    files.addAll(widgets);
    controllerWidgetStreamController.add(files);

    return widgets;
  }

  void parseWidget(ControllerWidget widget, XmlBuilder builder) {
    if (widget.widgets.isNotEmpty) {
      builder.element('objectgroup', nest: () {
        builder.attribute('id', widget.id);
        builder.attribute('name', widget.name);
        builder.attribute('class', widget.class_);
        builder.attribute(
            'offsetx', widget.position.x); // TODO: differs from x ?
        builder.attribute(
            'offsety', widget.position.y); // TODO: differs from y ?
        widget.widgets.forEach((child) {
          parseWidget(child, builder);
        });
      });
    } else if (widget.background != null) {
      builder.element('imagelayer', nest: () {
        widgetAttrs(widget, builder);
      });
    } else {
      builder.element('object', nest: () {
        widgetAttrs(widget, builder);
      });
    }
  }

  void widgetAttrs(ControllerWidget widget, XmlBuilder builder) {
    builder.attribute('id', widget.id);
    builder.attribute('name', widget.name);
    builder.attribute('class', widget.class_);
    builder.attribute('x', widget.position.x);
    builder.attribute('y', widget.position.y);
  }

  Future<File> saveMap(ControllerMap map) {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.attribute('encoding', 'UTF-8');
    // map
    builder.element('map', nest: () {
      builder.attribute('version', '1.9');
      builder.attribute("tiledversion", "1.9.2");
      builder.attribute("orientation", "orthogonal");
      builder.attribute("renderorder", "right-down");
      builder.attribute("width", map.size.width);
      builder.attribute("height", map.size.height);
      builder.attribute("tilewidth", TILE_SIZE);
      builder.attribute("tileheight", TILE_SIZE);
      builder.attribute("infinite", "0");
      // builder.attribute("backgroundcolor", "#212121");
      builder.attribute("nextlayerid", map.nextLayerId);
      builder.attribute("nextobjectid", map.nextObjectId);
      // Tiled editor settings
      builder.element("editorsettings", nest: () {
        builder.element("export", nest: () {
          builder.attribute("target", map.name);
          builder.attribute('format', 'xml');
        });
      });
      // tileset
      if (map.backgrounds.isNotEmpty) {
        map.backgrounds.forEach((bg) {
          builder.element("tileset", nest: () {
            builder.attribute("firstgid", "1"); // tile index on which to start
            builder.attribute('name', bg.name);
            builder.attribute("tilewidth", TILE_SIZE);
            builder.attribute("tileheight", TILE_SIZE);
            builder.attribute('tilecount', bg.size.width * bg.size.height);
            builder.attribute('columns', bg.size.height);
            builder.element('image', nest: () {
              builder.attribute('source', bg.source);
              // builder.attribute('width', bg.image.width); // FIXME: jsonserializable
              // builder.attribute('height', bg.image.height);
            });
          });
        });
      }
      // main layer
      builder.element('layer', nest: () {
        builder.attribute('id', 1);
        builder.attribute('name', 'Controller');
        builder.attribute("width", map.size.width);
        builder.attribute("height", map.size.height);
        builder.element('data', nest: () {
          builder.attribute('encoding', 'csv');
          builder.text(map.layer!.data.join(','));
        });
      });
      // widgets
      map.widgets.forEach((widget) {
        parseWidget(widget, builder);
      });
    });
    final document = builder.buildDocument();
    return File(map.path).writeAsString(document.toXmlString());
  }
}

/// Error thrown when a [ControllerWidget] with a given id is not found.
class ControllerWidgetNotFoundException implements Exception {}

class ControllerWidgetInvalidTiled implements Exception {}
