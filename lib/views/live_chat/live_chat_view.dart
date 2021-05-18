import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';

import 'live_chat_view_mobile.dart';

class LiveChat extends StatefulWidget {
  const LiveChat({Key key}) : super(key: key);
  static const TAG = "/liveChat";

  @override
  _LiveChatState createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: LiveChatMobilePortrait(),
      ),
    );
  }
}
