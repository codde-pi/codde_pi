import 'dart:convert';

import 'package:codde_pi/core/components/controller/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart';

class CJson {
  String? data;
  Map<String, dynamic> widgetMap = {};
  Size? mapSize;

  // Future<Type> widgetName(String name) async {
  //   MirrorSystem mirrors = currentMirrorSystem();
  //   LibraryMirror lm = mirrors.libraries['test'];
  //   ClassMirror cm = lm.classes['TestClass'];
  //   Future tcFuture = cm.newInstance('', []);
  //   return tcFuture.then((InstanceMirror im) {
  //     var tc = im.reflectee;
  //     tc.doStuff();
  //   });
  // }
  Future<Map> openJson(String path) async {
    final String response = await rootBundle.loadString(path);
    var _map = await json.decode(response);
    data = _map.toString();
    print('json $_map');
    // MAP SIZE
    if (!_map.keys.contains("map_size")) {
      // TODO: error
      print("no map_size");
      mapSize = null;
    } else {
      Map size = _map["map_size"];
      if (!size.keys.contains("width") || !size.keys.contains("height")) {
        // TODO: raise error
        print('no width or height');
        mapSize = null;
      } else {
        mapSize = Size((size["width"] as int).toDouble(),
            (size["height"] as int).toDouble());
      }
    }
    // WIDGETS
    if (!_map.keys.contains("widgets")) {
      // TODO: error
      print("no widgets. Add someone !");
    } else {
      widgetMap = _map["widgets"];
    }

    return widgetMap;
  }
}

dynamic fromJsonCtrl(String name, Map<String, dynamic> json, Socket socket) {
  switch (name) {
    case "simple_button":
      return C_SimpleButton.fromJson(socket, json);
  }
}

dynamic fromJsonEdit(String name, Map<String, dynamic> json) {
  switch (name) {
    case "simple_button":
      print('E_simple_button');
      return E_SimpleButton.fromJson(json);
    default:
      print('dirty list');
      return Container();
  }
}

enum CJsonDataName {
  size,
  widget,
  data
}