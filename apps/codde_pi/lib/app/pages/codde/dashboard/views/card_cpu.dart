part of 'cards.dart';

class CardCpu extends CardBase {
  final (double, double)? cpu;
  const CardCpu({super.key, this.cpu});

  @override
  Widget build(BuildContext context) {
    //CPU 1 => usage
    //CPU 2 => free

    if (cpu == null) {
      return const Center(
        child: Text('ERROR'),
      );
    }
    double maxCpuCapacity = (cpu!.$1 + cpu!.$2);
    var cpuColor = Theme.of(context).disabledColor;
    if (maxCpuCapacity / cpu!.$1 <= levelRed) {
      cpuColor = Colors.red;
    } else if (maxCpuCapacity / cpu!.$1 <= levelOrange) {
      cpuColor = Colors.orange;
    } else {
      cpuColor = valueColor(context);
    }
    final Map<String, double> cpuMap = {'usage': cpu!.$1, 'free': cpu!.$2};
    return Card(
      child: Stack(
        children: [
          PieChart(
            dataMap: cpuMap,
            chartRadius: itemHeight(context),
            chartType: ChartType.ring,
            initialAngleInDegree: 0,
            colorList: [cpuColor, Theme.of(context).disabledColor],
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: false,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: false,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
              /*chartValueStyle: TextStyle(color: Theme.of(context).disabledColor)*/
            ),
            ringStrokeWidth: chartWidth,
            centerText: '${cpu!.$1}GHz',
            centerTextStyle: TextStyle(
                fontFamily: 'aldrich', color: Theme.of(context).hoverColor),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(gridMargin),
                child: Text('CPU Frequency')),
          ),
        ],
      ),
    );
  }
}
