import 'package:codde_pi/app/pages/soon/newsletter_registration.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Soon extends StatelessWidget {
  final String title;
  Soon({super.key, required this.title});
  final bar = GetIt.I.get<DynamicBarState>();
  @override
  Widget build(BuildContext context) {
    if (bar.destinations[bar.currentPage].widget == this) {
      bar.disableFab();
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(
            height: 48.0,
          ),
          Text('${title.toLowerCase()} will be available soon !'),
          const SizedBox(height: 48.0),
          FloatingActionButton.extended(
            onPressed: () => showDialog(
                context: context,
                builder: (context) => NewsletterRegistration()),
            label: const Text("GET NOTIFIED"),
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
    );
  }
}
