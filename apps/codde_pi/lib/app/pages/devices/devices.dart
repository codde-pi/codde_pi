import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:flutter/material.dart';

import 'views/device_collection.dart';

class Devices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Devices();
}

class _Devices extends State<Devices> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BreadCrumbScaffold(tabs: [
      DynamicBarPager.deviceCollection,
      DynamicBarPager.deviceGarage,
      DynamicBarPager.devicePlayground,
    ], initialStep: DeviceCollection());
  }
}
