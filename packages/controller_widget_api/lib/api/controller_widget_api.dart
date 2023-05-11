import 'dart:io';

import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:rxdart/subjects.dart';
import 'package:xml/xml.dart';

part 'controller_widget_repository.dart';

class ControllerWidgetApi {
  ControllerWidgetApi(
      {required ControllerMap map, Map<int, ControllerWidget>? widgets})
      : mapStreamController = BehaviorSubject<ControllerMap>.seeded(map),
        controllerWidgetStreamController =
            BehaviorSubject<Map<int, ControllerWidget>>.seeded(widgets ?? {});

  final mapStreamController;
  final controllerWidgetStreamController;

  Stream<Map<int, ControllerWidget>> streamWidgets() {
    return controllerWidgetStreamController.asBroadcastStream();
  }

  Stream<ControllerMap> streamMap() {
    return mapStreamController.asBroadcastStream();
  }

  Map<int, ControllerWidget> getWidgetsOnce() {
    return controllerWidgetStreamController.value;
  }

  Future<FileSystemEntity>? deleteMap(ControllerMap map) {
    return File(map.path).delete();
  }

  ControllerWidget? removeWidget(int id) {
    final widgets = Map.of(controllerWidgetStreamController.value);

    ControllerWidget? removedWidget = widgets.remove(id);
    controllerWidgetStreamController.add(widgets);
    return removedWidget;
  }

  ControllerWidget modifyWidget(ControllerWidget newVersion) {
    final wgts = Map.of(controllerWidgetStreamController.value);
    wgts[newVersion.id] = newVersion;
    controllerWidgetStreamController.add(wgts);

    return newVersion;
  }

  List<ControllerWidget> parseLayers(List<Layer> layers) {
    Iterable<ControllerWidget?> widgets = layers.map((layer) {
      // TODO: update layerType after adding imageLayer edition
      if (layer.id != null && layer.type == LayerType.objectGroup) {
        return ControllerWidget(
            id: layer.id!,
            background: null,
            class_: EnumToString.fromString(
                ControllerClass.values, layer.class_ ?? ''),
            name: layer.name,
            x: layer.x,
            y: layer.y);
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
    final files = Map.of(controllerWidgetStreamController.value);
    files[widget.id] = widget;
    controllerWidgetStreamController.add(files);
    var newMap =
        mapStreamController.value.copyWith(nextObjectId: widget.id + 1);
    mapStreamController.add(newMap);
    return widget;
  }

  List<ControllerWidget> addAll(List<ControllerWidget> widgets) {
    // file list stream event
    final files = Map.of(controllerWidgetStreamController.value);
    widgets.forEach((element) {
      files[element.id] = element;
    });
    controllerWidgetStreamController.add(files);

    return widgets;
  }

  void parseWidget(ControllerWidget widget, XmlBuilder builder) {
    if (widget.widgets.isNotEmpty) {
      builder.element('objectgroup', nest: () {
        widgetAttrs(widget, builder);
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
    builder.attribute('x', widget.x);
    builder.attribute('y', widget.y);
  }

  Future<File> createMap() {
    final map = mapStreamController.value;
    map.toJson().values.forEach((value) {
      assert(value != null);
    });
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.attribute('encoding', 'UTF-8');
    // map
    builder.element('map', nest: () {
      builder.attribute('version', '1.9');
      builder.attribute("tiledversion", "1.9.2");
      builder.attribute("orientation", "orthogonal");
      builder.attribute("renderorder", "right-down");
      builder.attribute("width", map.width);
      builder.attribute("height", map.height);
      builder.attribute("tilewidth", TILE_SIZE);
      builder.attribute("tileheight", TILE_SIZE);
      builder.attribute("infinite", "0");
      // builder.attribute("backgroundcolor", "#212121");
      builder.attribute("nextlayerid", map.nextLayerId);
      builder.attribute("nextobjectid", map.nextObjectId);
      // Controller properties
      if (map.properties != null) {
        builder.element('properties', nest: () {
          map.properties!.toJson().entries.forEach((prop) {
            if (prop.value != null) {
              builder.element('property', nest: () {
                builder.attribute('name', prop.key);
                builder.attribute('value', prop.value);
              });
            }
          });
        });
      }
      // tileset
      if (map.backgrounds != null && map.backgrounds!.isNotEmpty) {
        map.backgrounds!.forEach((bg) {
          builder.element("tileset", nest: () {
            builder.attribute("firstgid", "1"); // tile index on which to start
            builder.attribute('name', bg.name);
            builder.attribute("tilewidth", TILE_SIZE);
            builder.attribute("tileheight", TILE_SIZE);
            builder.attribute('tilecount', bg.size.width * bg.size.height);
            builder.attribute('columns', bg.size.height);
            builder.element('image', nest: () {
              builder.attribute('source', bg.source);
              // FIXME: JsonSerializable
              // builder.attribute('width', bg.image.width);
              // builder.attribute('height', bg.image.height);
            });
          });
        });
      }
      // main layer
      builder.element('layer', nest: () {
        builder.attribute('id', 1);
        builder.attribute('name', 'datalayer');
        builder.attribute("width", map.width);
        builder.attribute("height", map.height);
        builder.element('data', nest: () {
          builder.attribute('encoding', 'csv');
          builder.text(
              List.generate(map.width! * map.height!, (index) => 0).join(','));
        });
      });
      // widgets
      // TODO: next feature update
      // widgets.forEach((widget) {
      //   parseWidget(widget, builder);
      // });
    });
    final document = builder.buildDocument();
    return File(map.path).writeAsString(document.toXmlString());
  }

  Future<File> saveMap() {
    final map = mapStreamController.value;
    final widgets = Map.of(controllerWidgetStreamController.value);
    final file = new File(map.path);
    final document = XmlDocument.parse(file.readAsStringSync());
    final builder = XmlBuilder();
    builder.xml(file.readAsStringSync());
    // widgets
    List<int> existingWgts = [];
    document.rootElement
        .findAllElements('objectgroup')
        .where((element) =>
            element.getAttribute('id') != null &&
            widgets.keys.contains(int.parse(element.getAttribute('id')!)))
        .forEach((element) {
      element.replace(widgets[int.parse(element.getAttribute('id')!)]!.toXml());
      existingWgts.add(int.parse(element.getAttribute('id')!));
    });
    widgets.keys
        .where(
      (id) => !existingWgts.contains(id),
    )
        .forEach((filteredId) {
      document.rootElement.children.add(widgets[filteredId]!.toXml());
    });

    // map
    if (map.backgrounds != null) {
      // TODO: add new tileset to the map
    }
    // find existing LAYER
    if (map.width != null && map.height != null) {
      final dataLayer = document.rootElement
          .findElements('layer')
          .where((element) => element.findElements('data') != null)
          .first;
      final nextId;
      if (dataLayer != null) {
        nextId = int.parse(dataLayer.getAttribute('id')!);
      } else {
        nextId = int.parse(document.rootElement.getAttribute('nextlayerid')!);
        document.rootElement
            .setAttribute('nextlayerid', (nextId + 1).toString());
      }
      // Generate DATA LAYER
      XmlNode data = XmlElement(XmlName('data'),
          [XmlAttribute(XmlName("encoding"), "csv")], [], false);
      data.innerText =
          List.generate(map.width! * map.height!, (index) => 0).join(',');
      XmlNode newLayer = XmlElement(XmlName('layer'), [
        XmlAttribute(XmlName("id"), nextId.toString()),
        XmlAttribute(XmlName("width"), map.width.toString()),
        XmlAttribute(XmlName("height"), map.height.toString()),
        XmlAttribute(XmlName("name"), "datalayer")
      ], [
        data
      ]);
      if (dataLayer != null) {
        dataLayer.replace(newLayer);
      } else {
        document.rootElement.children.add(newLayer);
      }
    }
    if (map.nextLayerId != null) {
      document.rootElement
          .setAttribute('nextlayerid', map.nextLayerId.toString());
    }
    if (map.nextObjectId != null) {
      document.rootElement
          .setAttribute('nextobjectid', map.nextObjectId.toString());
    }

    return File(map.path).writeAsString(document.toXmlString());
  }
}

/// Error thrown when a [ControllerWidget] with a given id is not found.
class ControllerWidgetNotFoundException implements Exception {}

class ControllerWidgetInvalidTiled implements Exception {}