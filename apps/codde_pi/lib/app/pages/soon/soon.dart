import 'package:codde_pi/app/pages/soon/newsletter_registration.dart';
import 'package:flutter/material.dart';

import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';

class Soon extends DynamicBarWidget {
  final String title;
  Soon({super.key, required this.title});
  @override
  setFab(context) {
    bar.disableFab();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    /* if (bar.destinations[bar.currentPage].widget == this) {
      bar.disableFab();
    } */
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

  @override
  final List<DynamicBarMenuItem> bottomMenu = [
    DynamicBarMenuItem(name: "Get Notified", iconData: Icons.notifications),
    DynamicBarMenuItem(name: "Support Development", iconData: Icons.coffee)
  ];

  @override
  void setIndexer(context) {
    bar.setIndexer((_) {}); // TODO: not yet implemented
  }
}
