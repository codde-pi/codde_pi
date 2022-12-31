import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:json_annotation/json_annotation.dart';

part 'simple_button.g.dart';

class C_SimpleButton extends StatelessWidget {
  double height;
  double width;
  double x;
  double y;
  Socket socket;

  C_SimpleButton(this.socket, this.x, this.y,
      {this.width = 75.0, this.height = 75.0, super.key});

  factory C_SimpleButton.fromJson(Socket socket, Map<String, dynamic> json) =>
      _$C_SimpleButtonJson(socket, json);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      height: height,
      width: width,
      child: GestureDetector(
          onTap: () {
            print("hello world :')");
            socket.emit('my_event', 'test2');
          },
          child: Container(color: Colors.red)),
    ); // CustomPaint(child: SimpleButtonPainter(context, (p0) => null),)
  }
}

C_SimpleButton _$C_SimpleButtonJson(Socket socket, Map<String, dynamic> json) =>
    C_SimpleButton(socket, (json['x'] as int).toDouble(),
        (json['y'] as int).toDouble() // TODO
        );

@JsonSerializable()
class E_SimpleButton extends StatelessWidget {
  double height;
  double width;
  double x;
  double y;

  E_SimpleButton(this.x, this.y,
      {this.width = 75.0, this.height = 75.0});

  factory E_SimpleButton.fromJson(Map<String, dynamic> json) =>
      _$E_SimpleButtonFromJson(json);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      height: height,
      width: width,
      child: Draggable<String>(
        data: 'simple_button',
        feedback: const CircleAvatar(
          backgroundColor: Colors.green,
          radius: 40,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        childWhenDragging: Container(),
        child: const CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 40,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  E_SimpleButton fromMap(Map map) {
    return E_SimpleButton(map["x"], map["y"],
        width: map["width"], height: map["height"]);
  }
}

// REGION OLD METHOD
class SimpleButtonPainter extends CustomPainter {
  final BuildContext context;
  Function(Map<String, Object>) emit;

  SimpleButtonPainter(
      this.context, this.emit); // context from CanvasTouchDetector

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);

    /*myCanvas.drawCircle(const Offset(10, 10), 60, Paint()..color = Colors.orange,
        onTapDown: (tapdetail) {
      print("orange Circle touched");
      stdout.writeln("circle touched");
      emit({"simple_button": true});
    }/*, onPanDown: (tapdetail) {
      print("orange circle swiped");
      stdout.writeln("circle pan");
    }*/);*/
    canvas.drawCircle(const Offset(10, 10), 60, Paint()..color = Colors.orange);

    /*myCanvas.drawLine(
        Offset(0, 0),
        Offset(size.width - 100, size.height - 100),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 50,
        onPanUpdate: (detail) {
          print('Black line Swiped'); //do cooler things here. Probably change app state or animate
        });*/
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SimpleButton extends StatelessWidget {
  final Function(Map) emit;

  const SimpleButton(this.emit, {super.key});

  @override
  Widget build(BuildContext context) {
    return CanvasTouchDetector(
      builder: (context) {
        return CustomPaint(
          painter: SimpleButtonPainter(context, emit),
        );
      },
    );
  }
}
// ENDREGION
