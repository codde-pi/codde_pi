import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/logger.dart';
import 'package:flutter/material.dart';

import 'soon/donation.dart';
import 'soon/newsletter_registration.dart';

class Community extends StatelessWidget {
  Community({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicBarScaffold(
      section: DynamicBarPager.community,
      indexer: _setIndexer,
      pages: [
        DynamicBarMenuItem(destination: DynamicBarPager.getNotified),
        DynamicBarMenuItem(destination: DynamicBarPager.donation),
      ],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Community", style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(
              height: 48.0,
            ),
            const Text(
                'Collaborative decentralised plaform to build and share awesome DIY projects'),
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
      ),
    );
  }

  bool _setIndexer(BuildContext context, int p) {
    switch (p) {
      case 1:
        logger.d('Go to Donation');
        Navigator.of(context).pop();
        goToDonation(context);
        break;
    }
    return true; // usually false
  }

  Future goToDonation(context) async {
    return await showDialog(context: context, builder: (context) => Donation());
  }
}
