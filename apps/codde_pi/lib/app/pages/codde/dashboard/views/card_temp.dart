part of 'cards.dart';

/* class CardTemp extends CardBase {
  final List bigData;
  const CardTemp(this.bigData, {super.key});

  @override
  Widget build(BuildContext context) {
    //TEMP
    Color tempColor = Defaults.colors10.first.withAlpha(80);
    final dataTemp = bigData.last;

    if (maxTemp / dataTemp <= levelRed) {
      tempColor = Colors.red;
    } else if (maxTemp / dataTemp <= levelOrange) {
      tempColor = Colors.orange;
    } else {
      tempColor = valueColor(context).withAlpha(80);
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bigData.length > 4
              ? Expanded(
                  child: ScrollConfiguration(
                    behavior: const MaterialScrollBehavior(),
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      scrollDirection: Axis.horizontal,
                      /* controller: scrollController,*/
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 300.0 + bigData.length * 1.25,
                        /*height: itemHeight,*/
                        child: Chart(
                          data: bigData,
                          variables: {
                            'time': Variable(
                              accessor: (Map map) => map['time'] as String,
                              scale: OrdinalScale(tickCount: 5),
                            ),
                            'temp': Variable(
                              accessor: (Map map) =>
                                  (map['temp'] ?? double.nan) as num,
                            ),
                          },
                          marks: [
                            AreaElement(
                              shape: ShapeAttr(
                                  value: BasicAreaShape(smooth: false)),
                              color: ColorAttr(value: tempColor),
                            ),
                            LineElement(
                              style: LineStyle(),
                              shape: ShapeAttr(
                                  value: BasicLineShape(smooth: false)),
                              size: SizeAttr(value: 0.5),
                              color: ColorAttr(
                                  value: Theme.of(context).highlightColor),
                            ),
                          ],
                          axes: [
                            Defaults.horizontalAxis,
                            Defaults.verticalAxis,
                          ],
                          selections: {
                            'touchMove': PointSelection(
                              on: {
                                GestureType.scaleUpdate,
                                GestureType.tapDown,
                                GestureType.longPressMoveUpdate
                              },
                              dim: Dim.y,
                            )
                          },
                          tooltip: TooltipGuide(
                            followPointer: [false, true],
                            align: Alignment.topRight,
                            offset: const Offset(-20, -20),
                          ),
                          crosshair:
                              CrosshairGuide(followPointer: [false, true]),
                        ),
                      ),
                    ),
                  ),
                )
              : const Center(child: Text('Waiting for data')),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Temperature'),
            ),
          ),
        ],
      ),
    );
  }
} */
