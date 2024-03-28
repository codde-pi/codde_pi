import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/codde_controller/codde_controller.dart';
import 'package:codde_pi/components/codde_overview/codde_overview.dart';
import 'package:codde_pi/components/codde_runner/codde_runner.dart';
import 'package:codde_pi/components/views/codde_tile.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/logger.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ExecutableOverview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExecutableOverview();
  }

  final Project project;
  ExecutableOverview({super.key, required this.project});
}

class _ExecutableOverview extends State<ExecutableOverview> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Executables",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          IconButton(
              onPressed: () => setState(() {}), icon: const Icon(Icons.refresh))
        ],
      ),
      StreamBuilder<List<FileEntity>>(
          initialData: widget.project.executables,
          stream: listExecutables(),
          builder: (builder, AsyncSnapshot<List<FileEntity>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('No executables found'));
            }

            // Filter results
            logger.d("LIST ${snapshot.data?.map((e) => e.name)}");
            List<FileEntity> execs = widget.project.executables +
                snapshot.data!
                    .where((f) => isInTreeExecutable(f.name))
                    .toList();

            // Render
            return Expanded(
              child: ListView(
                children: [
                  ...execs.map((e) => CoddeTile(
                        title: Text(e.name),
                        subtitle: Text(e.path),
                        tailing: IconButton(
                          icon: Icon(Icons.play_arrow),
                          color: Colors.green,
                          onPressed: () {/* TODO: Go to RUN page */},
                        ),
                        leading: Icon(
                            isPythonFile(e.name) ? Icons.code : Icons.gamepad),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => CoddeRunner(e.path))),
                        onLongPress: () {/* TODO: options DELETE, EDIT */},
                      )),
                  if (snapshot.connectionState != ConnectionState.done)
                    const Padding(
                      padding: EdgeInsets.all(widgetGutter),
                      child: LinearProgressIndicator(),
                    )
                ],
              ),
            );
            // if (snapshot.connectionState != ConnectionState.done)
          })
    ]);
  }

  CoddeBackend get backend => GetIt.I.get<CoddeBackend>();

  Stream<List<FileEntity>> listExecutables() async* {
    yield* backend.listenChildren(widget.project.path, recursive: true);
  }
}
