import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/voice_search/voice_search_view_mobile.dart';

class VoiceSearch extends StatelessWidget {
  const VoiceSearch({Key key}) : super(key: key);

  static const TAG = "/voiceSearch";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: VoiceSearchMobilePortrait(),
      ),
    );
  }
}
