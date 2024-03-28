part of 'cards.dart';

class CardMem extends CardBase {
  final (double, double)? data;
  const CardMem(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Center(
        child: Text('ERROR'),
      );
    }
    final memUsage = data!.$1;
    final memFree = data!.$2;
    var memColor = Theme.of(context).disabledColor;
    if (2 - (memUsage / 100) <= levelRed) {
      memColor = Colors.red;
    } else if (2 - (memUsage / 100) <= levelOrange) {
      memColor = Colors.orange;
    } else {
      memColor = valueColor(context);
    }
    final Map<String, double> mem = {'usage': memUsage, 'free': memFree};
    return Card(
      child: Stack(
        children: [
          PieChart(
            dataMap: mem,
            chartRadius: itemHeight(context),
            chartType: ChartType.ring,
            initialAngleInDegree: 0,
            colorList: [memColor, Theme.of(context).disabledColor],
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
            centerText: '${mem['usage']}%',
            centerTextStyle: TextStyle(
                fontFamily: 'aldrich', color: Theme.of(context).hoverColor),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(gridMargin),
                child: Text('Memory Usage')),
          ),
        ],
      ),
    );
  }
}
