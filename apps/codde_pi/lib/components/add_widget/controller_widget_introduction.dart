import 'package:codde_pi/codde_widgets/codde_widgets.dart';
import 'package:codde_pi/components/add_widget/widget_api.dart';
import 'package:codde_pi/logger.dart';
import 'package:codde_pi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ControllerWidgetIntroduction extends StatelessWidget {
  final ControllerWidgetDef widget;
  ControllerWidgetIntroduction({required this.widget});
  /* @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getWidgetDoc(widget),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data == null
              ? const Center(child: Text("No documentation available"))
              // : SingleChildScrollView(
              /* child: */ : Markdown(data: snapshot.data!);
          // );
        });
  }

  Future<String> getWidgetDoc(ControllerWidgetDef def) {
    return rootBundle
        .loadString('assets/codde_doc/widgets/${def.class_.name}.md');
  } */
  late final WidgetApi _api = WidgetApi(class_: widget.class_, id: 0);
  late final WebViewController _controller = WebViewController
      .fromPlatformCreationParams(
          const PlatformWebViewControllerCreationParams())
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
        Uri.parse("https://docs.codde-pi.com/widgets/buttons/${_api.docPath}"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebViewWidget(controller: _controller));
  }
}
