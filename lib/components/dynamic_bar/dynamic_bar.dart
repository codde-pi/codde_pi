import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicBar extends StatelessWidget {
  final bool nested;

  final List<DynamicBarDestination>? destinations;
  final int? startPage;

  const DynamicBar(
      {super.key, this.destinations, this.startPage, this.nested = false});

  @override
  Widget build(BuildContext context) {
    // TODO: optional destinations and startPage
    return Scaffold(
      body: GetBuilder<DynamicBarController>(
        builder: (s) => IndexedStack(
            index: s.currentPage,
            /* physics: const NeverScrollableScrollPhysics(), */
            children: s.pages),
      ),
      bottomNavigationBar: GetBuilder<DynamicBarController>(
        builder: (s) => BottomAppBar(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (nested) ...[
                RotatedBox(
                  quarterTurns: 2,
                  child: IconButton(
                      onPressed: () => Get.offAllNamed('/'),
                      icon: const Icon(Icons.logout)),
                ),
                const SizedBox(height: 24.0, child: VerticalDivider()),
              ],
              ...s.paged.map((DynamicBarDestination e) => IconButton(
                  onPressed: () => s.setPage(e), icon: Icon(e.iconData))),
              if (s.fab != null)
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      onPressed: () =>
                          s.fab!.action != null ? s.fab!.action!() : {},
                      child: Icon(s.fab!.iconData),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
