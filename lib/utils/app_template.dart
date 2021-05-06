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
    if (Globals.isDarkMode != null) {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      bool darkModeOn = brightness == Brightness.dark;
      Globals.isDarkMode.setValue(darkModeOn);
    }

    Widget content = SafeArea(child: widget.child);
    return Globals.isDarkMode == null
        ? FutureBuilder(
            future: Globals.updatePrefs(),
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              else
                return content;
            },
          )
        : content;
  }
}
