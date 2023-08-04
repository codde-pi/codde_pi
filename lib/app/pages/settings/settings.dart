import 'package:codde_pi/app/pages/settings/license.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_widget.dart';
import 'package:codde_pi/components/dynamic_bar/state/dynamic_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Settings extends DynamicBarWidget {
  Settings({super.key});
  @override
  setFab(context) {
    bar.disableFab();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: user auth <- UserInfo(),
            Row(mainAxisSize: MainAxisSize.max, children: [
              const Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(
                    'Device' /*, style: Theme.of(context).textTheme.headline5*/),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(child: Container(color: Colors.white, height: 1.0)),
            ]),
            // TODO: Device list ?
            Row(mainAxisSize: MainAxisSize.max, children: [
              const Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(
                    'Conditions of use' /*, style: Theme.of(context).textTheme.headline5*/),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(child: Container(color: Colors.white, height: 1.0)),
            ]),
            ListTile(
              title: const Text('Terms and conditions of use'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => License(
                        uri: Uri(
                            scheme: "https",
                            host: "codde-pi.com",
                            path: "cgu")),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Privacy Charter'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => License(
                          uri: Uri(
                              scheme: "https",
                              host: "codde-pi.com",
                              path: "cgu"))),
                );
              },
            ),
            ListTile(
              title: const Text('License Creative Commons 4.0 BY-NC-ND'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => License(
                          uri: Uri(
                              scheme: "https",
                              host: "creativecommons.org",
                              path: "licenses/by-nc-nd/4.0/deed.fr"))),
                );
              },
            ),
            const ListTile(
                title: Text(
                    'Copyright © 2022 Mathis Lecomte, All rights reserved.')),
            ListTile(
              title: const Text('Thanks'),
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const SingleChildScrollView(
                          child: Text(
                              'Server icons created by Freepik - Flaticon - https://www.flaticon.com/free-icons/server\n\n'
                              'Remote Desktop Icon - Flaticon - https://www.flaticon.com/free-icons/remote-desktop')),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK')),
                      ],
                    );
                  }),
            ),
            Row(mainAxisSize: MainAxisSize.max, children: [
              const Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(
                    'Leave' /*, style: Theme.of(context).textTheme.headline5*/),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(child: Container(color: Colors.white, height: 1.0)),
            ]),
          ],
        ),
      ),
    );
  }
}
