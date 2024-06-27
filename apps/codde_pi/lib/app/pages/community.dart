import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/logger.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'soon/donation.dart';
import 'soon/newsletter_registration.dart';

class Community extends StatelessWidget {
  const Community({super.key});

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
          onPressed: (c) async => await launchUrl(Uri(
                  scheme: "https",
                  host: "patreon.com",
                  path: "user",
                  query: "u=95462777"))
              .then((value) => true),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.only(left: widgetGutter, right: widgetGutter),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Community",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 48.0,
              ),
              const Text(
                  'Collaborative decentralised plaform to build and share awesome DIY projects'),
              const SizedBox(height: 48.0),
              FloatingActionButton.extended(
                onPressed: () => launchUrl(
                    Uri.parse("https://discord.com/invite/VvQfNWZPw3")),
                label: const Text("GET NOTIFIED"),
                icon: const Icon(Icons.notifications),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future goToDonation(context) async {
    return await showDialog(context: context, builder: (context) => Donation());
  }
}
