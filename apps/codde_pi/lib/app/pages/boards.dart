import 'package:codde_pi/app/pages/soon/soon.dart';
import 'package:flutter/material.dart';

class Boards extends StatelessWidget {
  const Boards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Soon(title: "Boards"),
    );
  }
}
/*
import 'dart:convert';

import 'package:codde_pi/src/model/diagrams/boards/rpi_4.dart';
import 'package:codde_pi/src/supplemental/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_table/json_table.dart';
import 'package:touchable/touchable.dart';
import '../../model/diagrams/boards/rpi_4_path.dart';

class Boards extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BoardsState();
}

const WIDTH = 1.0;

class BoardsState extends State<Boards> with SingleTickerProviderStateMixin {
  TransformationController interactiveController = TransformationController();
  String velocity = 'VELOCITY';

  double x = 1.0;
  double y = 1.0;
  double z = 1.0;

  double _sliderValue = 100;
  var _displayMode = [true, false];
  var data;

  //Decode your json string
  final String jsonSample='[{"id":1},{"id":2}]';
  late var fakeJson = jsonDecode(jsonSample);

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    final String response = await rootBundle.loadString('assets/api/boards.json');
    final result = await json.decode(response);
    */
/*for (var i=0; i< result[0]["pins"].length; i++) {
      result[0]["pins"][i]["#"] = i + 1;
    }*//*


    data = result[0]["pins"];
  }

  void onPanUpdate(details) {
    //print('update : x=$x y=$y');
    setState(() {
      x = x + details.delta.dx * (_sliderValue * 2);
      y = y + details.delta.dy * (_sliderValue * 2);
    });
  }

  void onUpdate() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return BackDrop(
      appBarTitle: 'Raspberry Pi 4',
      gesture: false,
      backLayer: Container(),
      frontLayer: Stack(
        fit: StackFit.expand,
        */
/*width: double.infinity,
        height: double.infinity,*//*

        children: [
          _displayMode[1] ? Center(
            child: ScrollConfiguration(
              behavior: ScrollBehavior(
                  androidOverscrollIndicator:
                  AndroidOverscrollIndicator.stretch),
              child: JsonTable(
                data ?? fakeJson,
                allowRowHighlight: true,
                rowHighlightColor: Theme.of(context).colorScheme.secondary,
                tableHeaderBuilder: (header) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6.0),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        color: Theme.of(context).backgroundColor),
                    child: Text(
                      header!,
                      textAlign: TextAlign.center,
                      */
/*style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w700, fontSize: 14.0,color: Colors.black87),*//*

                    ),
                  );
                },
                tableCellBuilder: (value) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 2.0, vertical: 6.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5,
                            color: Colors.grey.withOpacity(0.5))),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      */
/*style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14.0, color: Colors.grey[900]),*//*

                    ),
                  );
                },
              ),
            ),
          ) : Transform(
          alignment: FractionalOffset.centerRight,
          transform: Matrix4(
            1,0,0,0,
            0,1,0,0,
            0,0,1,0,
            0,0,0,1,
          )..translate(x, y)..scale(_sliderValue / 100),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: FittedBox(
            child: CanvasTouchDetector(
              builder: (context) =>
                  CustomPaint(
                    isComplex: true,
                    size: Size(WIDTH, (WIDTH * 1.4398923904688703)
                        .toDouble()), */
/*1.449256573350079*//*

                    //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPI4(context, onPanUpdate, onUpdate),
                    willChange: true,
                  ),
            ),
          ),
          ),
        ),
          Positioned(
            top: 0.0,
            right: 8.0,
            child: ToggleButtons(
              */
/* color: Colors.black.withOpacity(0.60),*//*

              */
/*selectedColor: Color(0xFF6200EE),
            selectedBorderColor: Color(0xFF6200EE),
            fillColor: Color(0xFF6200EE).withOpacity(0.08),
            splashColor: Color(0xFF6200EE).withOpacity(0.12),
            hoverColor: Color(0xFF6200EE).withOpacity(0.04),*//*

              */
/*borderRadius: BorderRadius.circular(4.0),*//*

              isSelected: _displayMode,
              onPressed: (index) {
                // Respond to button selection
                if (!_displayMode[index]) {
                  setState(() {
                    //_displayMode[index] = !_displayMode[index];
                    print(_displayMode[index]);
                    for (var i = 0; i<_displayMode.length; i++) {
                      _displayMode[i] = !_displayMode[i];
                      print(_displayMode[index]);
                    }
                  });
                }
              },
              children: [
                Icon(Icons.schema_outlined),
                Icon(Icons.table_rows_outlined)
              ],
            ),
          ),
        if (_displayMode[0]) Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Slider(
          value: _sliderValue,
          min: 100,
          max: 1000,
          label: _sliderValue.round().toString(),
          onChanged: (value) {
            setState(() {
              _sliderValue = value;

            });
          },
        ),),
        ]
      ),
    );
  }

}*/
