import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dynamic_bar/dynamic_bar.dart';
import 'package:codde_pi/components/utils/host_details.dart';
import 'package:codde_pi/core/exception.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/executable_overview.dart';

class CoddeOverview extends DynamicBarWidget {
  @override
  List<DynamicBarMenuItem> get bottomMenu => [
        DynamicBarMenuItem(
            name: "Overview",
            iconData: Icons.gamepad,
            destination: DynamicBarPager.coddeOverview),
        DynamicBarMenuItem(
            name: "Editor",
            iconData: Icons.code,
            destination: DynamicBarPager.editor),
        if (bar.isRemoteProject)
          DynamicBarMenuItem(
              name: "Dashboard",
              iconData: Icons.dashboard,
              destination: DynamicBarPager.dashboard),
        if (bar.isRemoteProject)
          DynamicBarMenuItem(
              name: "Terminal",
              iconData: Icons.terminal,
              destination: DynamicBarPager.terminal),
        DynamicBarMenuItem(
            name: "Diagram",
            iconData: Icons.schema,
            destination: DynamicBarPager.diagram),
        DynamicBarMenuItem(name: "Exit", iconData: Icons.exit_to_app)
      ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final coddeProject = Provider.of<CoddeState>(context).project;
    if (coddeProject == null) {
      throw RuntimeProjectException();
    }
    return Scaffold(
      appBar: AppBar(title: Text(coddeProject.name), leading: Container()),
      body: Column(
        children: [
          Expanded(
            child: ExecutableOverview(
              project: coddeProject,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Host",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              HostDetails(host: coddeProject.host),
              const SizedBox(height: widgetSpace),
            ],
          )
        ],
      ),
    );
  }

  void updateMenu(context, int index) {
    if (index == getLastMenuIndex) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/');
    } else {
      bar.selectMenuItem(index);
    }
  }

  @override
  void setFab(BuildContext context) {
    // TODO: implement setFab
  }

  @override
  void setIndexer(BuildContext context) {
    bar.setIndexer((p0) => updateMenu(context, p0));
  }
}
