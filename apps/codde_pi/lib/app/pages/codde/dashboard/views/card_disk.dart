part of 'cards.dart';

class CardDisk extends CardBase {
  final (double, double)? data;
  CardDisk(this.data);

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Center(
        child: Text('ERROR'),
      );
    }
    Color diskColor = Theme.of(context).disabledColor;
    final diskUsage = data!.$1;
    final diskFree = data!.$2;
    final diskSize = diskFree + diskUsage;

    if (diskSize / diskUsage <= levelRed) {
      diskColor = Colors.red;
    } else if (diskSize / diskUsage <= levelOrange) {
      diskColor = Colors.orange;
    } else {
      diskColor = valueColor(context);
    }
    final Map<String, double> disk = {"usage": diskUsage, "free": diskFree};
    return Card(
      child: Stack(children: [
        PieChart(
          dataMap: disk,
          chartRadius: itemHeight(context),
          chartType: ChartType.ring,
          initialAngleInDegree: 0,
          colorList: [diskColor, Theme.of(context).disabledColor],
          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: false,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: false,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
              chartValueStyle:
                  TextStyle(color: Theme.of(context).disabledColor)),
          ringStrokeWidth: chartWidth,
          centerText: '${disk['usage']}G',
          centerTextStyle: TextStyle(
              fontFamily: 'aldrich', color: Theme.of(context).hoverColor),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: EdgeInsets.all(gridMargin), child: Text('Disk Usage')),
        ),
      ]),
    );
  }
}
