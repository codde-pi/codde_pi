import 'package:codde_pi/components/forms/ssh_host_form.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NewHostDialog extends StatelessWidget {
  void createHost(Host host) {
    Hive.box<Host>('hosts').add(host);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('New Host'),
      ),
      body: Padding(
        padding: EdgeInsets.all(widgetGutter),
        child: SSHHostForm(
          cancel: () => Navigator.pop(context),
          validate: (host) {
            createHost(host);
            Navigator.pop(context, host);
          },
        ),
      ),
    );
  }
}
