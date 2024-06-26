import 'package:codde_pi/app/pages/settings/license.dart';
import 'package:codde_pi/main.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

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
                    return Scaffold(
                      body: ListView.builder(
                        itemCount: deps.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text("${deps[index].$1} - ${deps[index].$3}"),
                          subtitle: Text(deps[index].$2),
                        ),
                      ),
                      appBar: AppBar(
                        title: const Text('Thanks'),
                        leading: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close)),
                      ),
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
