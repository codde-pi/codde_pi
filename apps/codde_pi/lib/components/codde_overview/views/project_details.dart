import 'package:codde_pi/components/views/codde_tile.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';

class ProjectDetails extends StatelessWidget {
  Project project;
  ProjectDetails({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.description ?? 'No description provided'),
        const SizedBox(height: widgetSpace),
        // TODO: image of model ?
        //
        /* Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('WORKING DIRECTORY'),
            Text(
              (project.workDir ?? '---').toString(),
              softWrap: false,
              maxLines: 2,
            ),
            IconButton(
                onPressed: () {/* TODO: clipboard */},
                icon: const Icon(Icons.copy))
          ],
        ), */
        /* ListTile(
          title: const Text('FLASH STATUS'),
          trailing: Icon(
              project.published ? Icons.published_with_changes : Icons.lock),
        ), */
        ListTile(
            onTap: () => null,
            title: const Text('REPO ID'),
            subtitle: Text(
                (project.repo.isNotEmpty ? project.repo : '---').toString()),
            trailing: const Icon(Icons.copy)),
        ListTile(
          title: const Text('PUBLISH STATUS'),
          trailing: Icon(
              project.published ? Icons.published_with_changes : Icons.lock),
          /* IconButton(
                onPressed: () {/* TODO: publish on Radicle */},
                icon: const Icon(Icons.publish)) */
        ),
      ],
    );
  }
}
