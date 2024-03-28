part of 'cards.dart';

class CardVoltage extends CardBase {
  String data;
  CardVoltage(this.data, {super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Center(
            child: Text(
              (data != '' && data != null ? '${data}V' : '0V'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(widgetGutter), child: Text('Voltage')),
          ),
        ],
      ),
    );
  }
}
