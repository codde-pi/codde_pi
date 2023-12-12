import 'dart:ui';

enum DeviceScreenType { mobile, tablet, desktop }

// TODO: dead file
class ResponsiveTools {
  static DeviceScreenType screenType(Size size) {
    if (size.width <= 600.0) {
      return DeviceScreenType.mobile;
    } else if (size.width > 600.0 && size.width <= 1200) {
      return DeviceScreenType.tablet;
    } else {
      return DeviceScreenType.desktop;
    }
  }
}
