part of 'cards.dart';

abstract class CardBase extends StatelessWidget {
  const CardBase({super.key});

// getters
  Size screenSize(context) => MediaQuery.of(context).size;
  Color valueColor(context) => Theme.of(context).highlightColor;

  bool portraitMode(context) =>
      screenSize(context).height > screenSize(context).width;

  itemHeight(context) {
    final crossAxisCount = portraitMode(context) ? 2 : 4;
    return screenSize(context).width / crossAxisCount;
  }

  double itemWidth(context) => portraitMode(context)
      ? screenSize(context).width / 2
      : screenSize(context).width / 3;

  double ratio(context) => itemHeight(context) / itemWidth(context);
}
