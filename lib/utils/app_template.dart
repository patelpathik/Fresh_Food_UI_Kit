import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fresh_food/utils/globals.dart';

class AppTemplate extends StatefulWidget {
  final Widget child;

  const AppTemplate({Key key, @required this.child}) : super(key: key);

  @override
  _AppTemplateState createState() => _AppTemplateState();
}

class _AppTemplateState extends State<AppTemplate> {
  @override
  Widget build(BuildContext context) {
    Widget content = SafeArea(child: widget.child);
    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      bool darkModeOn = brightness == Brightness.dark;
      if (Globals.systemDarkMode != null)
        Globals.systemDarkMode.setValue(darkModeOn);
    }
    return FutureBuilder(
      future: Globals.updatePrefs(),
      builder: (context, snapshot) {
        if (snapshot.data == null)
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        else
          return content;
      },
    );
  }
}
