import 'package:codde_pi/app/pages/soon/donation.dart';
import 'package:codde_pi/app/pages/soon/newsletter_registration.dart';
import 'package:codde_pi/logger.dart';
import 'package:flutter/material.dart';

import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class Soon extends StatelessWidget {
  final String title;
  Soon({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return DynamicBarScaffold(
      section: DynamicBarPager.community,
      pages: [
        DynamicBarMenuItem(
            destination: DynamicBarPager.getNotified,
            onPressed: (_) async => await launchUrl(
                    Uri.parse("https://discord.com/invite/VvQfNWZPw3"))
                .then((value) => true)),
        DynamicBarMenuItem(
          destination: DynamicBarPager.donation,
          onPressed: (context) {
            Navigator.of(context);
            showDialog(context: context, builder: (context) => Donation());
            return true;
          },
        ),
      ],
      body: Center(
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
      ),
    );
  }

  Future goToDonation(context) async {
    return await showDialog(context: context, builder: (context) => Donation());
  }
}
