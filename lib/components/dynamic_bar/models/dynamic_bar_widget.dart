import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab_selector.dart';
import 'package:flutter/material.dart';

abstract class DynamicBarWidget extends StatelessWidget
    with DynamicFabSelector {
  const DynamicBarWidget({super.key});
}

abstract class DynamicBarStatefulWidget extends StatefulWidget
    with DynamicFabSelector {
  const DynamicBarStatefulWidget({super.key});
}
