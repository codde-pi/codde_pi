import 'package:codde_pi/components/project_launcher/cubit/project_launcher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_markdown_editor/simple_markdown_editor.dart';

class IntroduceProjectStep extends StatelessWidget {
  final nameController = TextEditingController(text: '');
  final descController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(hintText: 'Project name'),
          autofocus: true,
          autocorrect: false,
          controller: nameController,
          textInputAction: TextInputAction.next,
          onSubmitted: (value) {
            if (descController.text == '' || descController.text == null) {
              descController.text = """# ${nameController.value}
                  An amazing C.O.D.D.E. Pi project is starting here...""";
            }
          },
        ),
        Expanded(
          flex: 3,
          child: MarkdownFormField(
              controller: descController, enableToolBar: true),
        ),
        ElevatedButton(
            onPressed: () {
              context.read<ProjectLauncherCubit>().feedData({
                "name": nameController.text,
                "description": descController.text
              }, nextPage: true);
            },
            child: const Text(
                'continue')) // TODO: create bottom bar button with assignable content
      ],
    );
  }
}
