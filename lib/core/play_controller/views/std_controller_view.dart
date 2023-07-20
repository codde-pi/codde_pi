import 'package:codde_pi/core/play_controller/store/std_controller_store.dart';
import 'package:flutter/material.dart';

class StdControllerView extends StatelessWidget {
  final StdControllerStore store = StdControllerStore();

  StdControllerView({super.key});
  // TODO: GetIt socket instance

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const VerticalDivider(thickness: 2.0),
          Row(children: [
            Text(
              'STDIN',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
                onPressed: () => store.clearIn(), child: const Text('CLEAR'))
          ]),
          const VerticalDivider(thickness: 2.0),
          Expanded(flex: 1, child: Text(store.stdin)),
          const VerticalDivider(thickness: 2.0),
          Row(children: [
            Text(
              'STDIN',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
                onPressed: () => store.clearOut(), child: const Text('CLEAR'))
          ]),
          const VerticalDivider(thickness: 2.0),
          Expanded(flex: 1, child: Text(store.stdout)),
        ],
      ),
    );
  }
}
