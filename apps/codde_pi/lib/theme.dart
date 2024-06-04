import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:xterm/theme/terminal_theme.dart';

const accent = Color(0xFFE6B905); // FFFEB705
const background = Color(0xFF121212);
const widgetColor = Color(0xFF212121);
const error = Color(0xFFC5032B);
const surface = Color(0xFF121212);
const white = Color(0xFFE1E1E1);
const grey = Color(0xFFBDBDBD);
const dialog = Color(0xFF323232);
const disabled = Color(0xFF3B3B3B);
const light_grey = Color(0xFFABABAB);
const blue = Color(0xFF3137FD);
const success = Colors.green;
//todo: couleur verte (success) appartenant au thème
const primary = Color(0xFF212121);
const secondary = Color(0xFFFBF4F4);
const onOthers = Color(0xFF575550);

const widgetSpace = 48.0;
const widgetGutter = 24.0;
const defaultButtonSize = Size(88.0, 36.0);

ColorScheme _colorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: accent,
    onPrimary: primary,
    secondary: secondary,
    onSecondary: onOthers,
    error: error,
    onError: onOthers,
    background: background,
    onBackground: primary,
    surface: background,
    tertiary: blue,
    onTertiary: background,
    onSurface: grey);
ThemeData cddTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _colorScheme,
    fontFamily: GoogleFonts.shareTechMono().fontFamily,
    listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.all(8.0), style: ListTileStyle.list),
    dividerTheme: const DividerThemeData(thickness: 2.0));

final flameTextRenderer = TextPaint(
  style: TextStyle(
    fontSize: 18.0,
    fontFamily: 'ShareTechMono',
    color: BasicPalette.white.color,
  ),
);

class CheckboxColor extends MaterialStateColor {
  const CheckboxColor() : super(_defaultColor);

  static const int _defaultColor = 0xFFFEB705;
  static const int _pressedColor = 0x00000000;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}

class CheckColor extends MaterialStateColor {
  const CheckColor() : super(_defaultColor);

  static const int _defaultColor = 0xFF121212;
  static const int _pressedColor = 0x00000000;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}

class ErrorColor extends MaterialStateColor {
  const ErrorColor() : super(_defaultColor);

  static const int _defaultColor = 0xFFC5032B;
  static const int _pressedColor = 0xFFC50300;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}

TreeViewTheme treeViewTheme = TreeViewTheme(
  expanderTheme: const ExpanderThemeData(
    type: ExpanderType.caret,
    modifier: ExpanderModifier.none,
    position: ExpanderPosition.start,
    color: Colors.blueAccent,
    size: 20,
  ),
  labelStyle: const TextStyle(
    fontSize: 16,
    letterSpacing: 0.3,
  ),
  parentLabelStyle: const TextStyle(
    fontSize: 16,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w800,
    color: Colors.blueAccent,
  ),
  iconTheme: IconThemeData(
    size: 18,
    color: Colors.grey.shade800,
  ),
  colorScheme: const ColorScheme.light(),
);

ThemeData defaultTheme = ThemeData();

/*
class TerminalThemes {
  static const defaultTheme = TerminalTheme(
    cursor: 0XFFAEAFAD,
    selection: 0XFFFFFF40,
    foreground: 0XFFCCCCCC,
    background: 0xFF121212,
    //0XFF1E1E1E,
    black: 0XFF000000,
    red: 0XFFCD3131,
    green: 0XFF0DBC79,
    yellow: 0XFFE5E510,
    blue: 0XFF2472C8,
    magenta: 0XFFBC3FBC,
    cyan: 0XFF11A8CD,
    white: 0XFFE5E5E5,
    brightBlack: 0XFF666666,
    brightRed: 0XFFF14C4C,
    brightGreen: 0XFF23D18B,
    brightYellow: 0XFFF5F543,
    brightBlue: 0XFF3B8EEA,
    brightMagenta: 0XFFD670D6,
    brightCyan: 0XFF29B8DB,
    brightWhite: 0XFFFFFFFF,
    searchHitBackground: 0XFFFFFF2B,
    searchHitBackgroundCurrent: 0XFF31FF26,
    searchHitForeground: 0XFF000000,
  );

  static const whiteOnBlack = TerminalTheme(
    cursor: 0XFFAEAFAD,
    selection: 0XFFFFFF40,
    foreground: 0XFFFFFFFF,
    background: 0XFF000000,
    black: 0XFF000000,
    red: 0XFFCD3131,
    green: 0XFF0DBC79,
    yellow: 0XFFE5E510,
    blue: 0XFF2472C8,
    magenta: 0XFFBC3FBC,
    cyan: 0XFF11A8CD,
    white: 0XFFE5E5E5,
    brightBlack: 0XFF666666,
    brightRed: 0XFFF14C4C,
    brightGreen: 0XFF23D18B,
    brightYellow: 0XFFF5F543,
    brightBlue: 0XFF3B8EEA,
    brightMagenta: 0XFFD670D6,
    brightCyan: 0XFF29B8DB,
    brightWhite: 0XFFFFFFFF,
    searchHitBackground: 0XFFFFFF2B,
    searchHitBackgroundCurrent: 0XFF31FF26,
    searchHitForeground: 0XFF000000,
  );
}
*/

/*class HtmlTheme {
  BorderSide borderSide = BorderSide(color: disabled, width: 1.0);
  Border border = Border(
      bottom: BorderSide(color: disabled, width: 1.0),
      top: BorderSide(color: disabled, width: 1.0),
      left: BorderSide(color: disabled, width: 1.0),
      right: BorderSide(color: disabled, width: 1.0));

  Map<String, Style> get docTheme => {
        "h1, h2, h3": Style(color: accent),
        "td, tr": Style(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.topLeft,
            border: border)
        //todo: th scope row and col
      };
}*/

const double cPixelSize = 7.0;
const double cOutlineWidth = 2.0;
const double cNoWidth = 0.0;
