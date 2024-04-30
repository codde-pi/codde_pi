import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/app/pages/codde/state/codde_state.dart';
import 'package:codde_pi/components/dialogs/add_controller_map_dialog.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoMapFound extends StatelessWidget {
  dynamic Function(Function()) setState;

  NoMapFound({required this.setState});
  @override
  Widget build(BuildContext context) {
    final coddeProject = /* context
        .watch<CoddeState>()
        .project; // */
        Provider.of<CoddeState>(context).project;

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('No Map found on this project'),
        SizedBox(height: widgetGutter),
        FloatingActionButton.extended(
          onPressed: () async {
            FileEntity? file = await showDialog(
                context: context,
                builder: (context) => AddControllerMapDialog(
                    path: coddeProject.workDir, context: context));
            if (file != null) {
              setState(() {}); //store.askReload();
            }
          },
          label: Text('New Map'),
          icon: Icon(Icons.add),
        )
      ],
    ));
  }
}
